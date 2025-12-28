package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
class UserController {

    private static final Logger logger = LoggerFactory.getLogger(UserController.class);

    @Autowired
    private UserService userService;

    @Autowired
    private UserFormValidator userFormValidator;

    // バリデーターの登録
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.addValidators(userFormValidator);
    }

    @GetMapping("/register")
    public String showForm(Model model) {
        model.addAttribute("userForm", new UserForm());

        // 调试：打印所有 model 属性
        if (logger.isDebugEnabled()) {
            ModelMap modelMap = (ModelMap) model;
            logger.debug("Get Model attributes: {}", modelMap.keySet());
        }

        return "register";
    }

    @PostMapping("/register")
    public String register(@Validated @ModelAttribute UserForm userForm, BindingResult result, Model model) {

        // 単項目チェックと相関チェックエラーがない場合
        // 業務ロジックチェック実施
        if (!result.hasErrors()) {
            validateBusinessLogic(userForm, result);
        }

        // いずれのチェックエラーがあればフォームに戻る
        if (result.hasErrors()) {
            return "register";
        }

        // 正常時の処理
        userService.register(userForm);

        return "redirect:/register?success";
    }

    /**
     * 業務ロジックチェック
     * データベースアクセスを伴うチェックを実行
     *
     * @param form フォームオブジェクト
     * @param result BindingResult
     */
    private void validateBusinessLogic(UserForm form, BindingResult result) {

        // 1. メールアドレス重複チェック
        if (userService.existsByEmail(form.getEmail())) {
            result.rejectValue("email", "error.emailExists", "This email address is already registered");
        }
    }
}
