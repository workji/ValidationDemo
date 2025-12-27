package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
class UserController {

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
        return "register";
    }

    @PostMapping("/register")
    public String register(@Validated @ModelAttribute UserForm userForm, BindingResult result, Model model) {

        // 1. 単項目チェック & 2. 相関チェック (InitBinderで登録済みのため自動実行)
        // エラーがあればフォームに戻る
        if (result.hasErrors()) {
            return "register";
        }

        // 3. 業務ロジックチェック：メールアドレス重複
        // DB問い合わせが必要なものはService経由で行い、エラーならBindingResultに追加する
        if (userService.isEmailRegistered(userForm.getEmail())) {
            result.rejectValue("email", "Duplicate", "このメールアドレスは既に登録されています");
            return "register";
        }

        // 正常時の処理
        userService.register(userForm);
        return "redirect:/register?success";
    }
}
