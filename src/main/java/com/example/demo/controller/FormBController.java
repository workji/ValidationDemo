package com.example.demo.controller;

import com.example.demo.form.EmployeeForm;
import com.example.demo.service.EmployeeService;
import com.example.demo.validator.EmployeeValidator;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * フォームB: 画面上部に全エラーをまとめて表示する方式
 *
 * 処理の流れ：
 * 1. GET  /formB/register → 初期表示
 * 2. POST /formB/register → バリデーション → エラーあり→入力画面へ / エラーなし→完了画面へ
 */
@Controller
@RequestMapping("/formB")
public class FormBController {

    @Autowired
    private EmployeeValidator employeeValidator;

    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private MessageSource messageSource;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.addValidators(employeeValidator);
    }

    @GetMapping("/register")
    public String showForm(Model model) {
        model.addAttribute("employeeForm", new EmployeeForm());
        addSelectOptions(model);
        return "formB";
    }

    @PostMapping("/register")
    public String register(
            @Valid @ModelAttribute("employeeForm") EmployeeForm form,
            BindingResult bindingResult,
            Model model) {

        if (!bindingResult.hasErrors()) {
            validateBusinessLogic(form, bindingResult);
        }

        if (bindingResult.hasErrors()) {
            // エラーサマリー用のリストを作成
            List<ErrorMessage> errorMessages = convertToErrorMessageList(bindingResult);
            model.addAttribute("errorMessages", errorMessages);

            addSelectOptions(model);
            return "formB";
        }

        employeeService.registerEmployee(form);

        model.addAttribute("successMessage", "登録が完了しました");
        model.addAttribute("employeeName", form.getEmployeeName());

        return "success";
    }

    /**
     * 業務ロジックチェック
     */
    private void validateBusinessLogic(EmployeeForm form, BindingResult result) {

        if (employeeService.existsByEmail(form.getEmail())) {
            String message = getMessage("error.emailExists");
            result.rejectValue("email", "error.emailExists", message);
        }

        if (employeeService.existsByPhoneNumber(form.getPhoneNumber())) {
            String message = getMessage("error.phoneExists");
            result.rejectValue("phoneNumber", "error.phoneExists", message);
        }

        if (!employeeService.departmentExists(form.getDepartmentId())) {
            String message = getMessage("error.departmentNotFound");
            result.rejectValue("departmentId", "error.departmentNotFound", message);
        }
    }

    /**
     * BindingResultをErrorMessageリストに変換
     * 画面上部のエラーサマリー表示用
     *
     * @param bindingResult BindingResult
     * @return エラーメッセージリスト
     */
    private List<ErrorMessage> convertToErrorMessageList(BindingResult bindingResult) {
        List<ErrorMessage> errorMessages = new ArrayList<>();

        for (FieldError error : bindingResult.getFieldErrors()) {
            ErrorMessage errorMsg = new ErrorMessage();

            // フィールド名を日本語表示名に変換
            String fieldDisplayName = getFieldDisplayName(error.getField());
            errorMsg.setFieldName(fieldDisplayName);
            errorMsg.setMessage(error.getDefaultMessage());

            errorMessages.add(errorMsg);
        }

        return errorMessages;
    }

    /**
     * フィールド名を日本語表示名に変換
     * messages.propertiesから取得
     *
     * @param fieldName フィールド名
     * @return 日本語表示名
     */
    private String getFieldDisplayName(String fieldName) {
        String code = "field." + fieldName;
        try {
            return messageSource.getMessage(code, null, LocaleContextHolder.getLocale());
        } catch (Exception e) {
            // メッセージが見つからない場合はフィールド名をそのまま返す
            return fieldName;
        }
    }

    /**
     * セレクトボックスの選択肢をModelに追加
     */
    private void addSelectOptions(Model model) {
        String[][] departments = {
                {"1", "営業部"},
                {"2", "開発部"},
                {"3", "人事部"},
                {"4", "総務部"},
                {"5", "経理部"}
        };
        model.addAttribute("departments", departments);

        String[][] skillOptions = {
                {"java", "Java"},
                {"python", "Python"},
                {"javascript", "JavaScript"},
                {"sql", "SQL"},
                {"html_css", "HTML/CSS"},
                {"react", "React"},
                {"spring", "Spring Framework"}
        };
        model.addAttribute("skillOptions", skillOptions);
    }

    /**
     * メッセージソースからメッセージを取得
     */
    private String getMessage(String code) {
        return messageSource.getMessage(code, null, LocaleContextHolder.getLocale());
    }

    /**
     * エラーメッセージ用の内部クラス
     * Lombokを使わないため、Getter/Setterを手動実装
     */
    public static class ErrorMessage {
        private String fieldName;
        private String message;

        public ErrorMessage() {
        }

        public String getFieldName() {
            return fieldName;
        }

        public void setFieldName(String fieldName) {
            this.fieldName = fieldName;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
    }
}