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
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * フォームA: 各項目の直下にエラーを表示する方式
 *
 * 処理の流れ：
 * 1. GET  /formA/register → 初期表示
 * 2. POST /formA/register → バリデーション → エラーあり→入力画面へ / エラーなし→完了画面へ
 */
@Controller
@RequestMapping("/formA")
public class FormAController {

    @Autowired
    private EmployeeValidator employeeValidator;

    @Autowired
    private EmployeeService employeeService;

    @Autowired
    private MessageSource messageSource;

    /**
     * カスタムバリデーターを登録
     * これにより、@Validの実行時に自動的にEmployeeValidatorも実行される
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.addValidators(employeeValidator);
    }

    /**
     * 初期表示
     *
     * @param model Model
     * @return テンプレート名
     */
    @GetMapping("/register")
    public String showForm(Model model) {
        // 空のフォームオブジェクトをModelに追加
        model.addAttribute("employeeForm", new EmployeeForm());

        // セレクトボックスの選択肢を追加
        addSelectOptions(model);

        return "formA";
    }

    /**
     * フォーム送信処理
     *
     * @param form フォームオブジェクト
     * @param bindingResult バリデーション結果
     * @param model Model
     * @return テンプレート名またはリダイレクト先
     */
    @PostMapping("/register")
    public String register(
            @Valid @ModelAttribute("employeeForm") EmployeeForm form,
            BindingResult bindingResult,
            Model model) {

        // ========== 業務ロジックチェック ==========
        // アノテーションバリデーションとカスタムバリデーションが
        // 正常に通過した場合のみ実行

        if (!bindingResult.hasErrors()) {
            validateBusinessLogic(form, bindingResult);
        }

        // エラーがある場合は入力画面に戻る
        if (bindingResult.hasErrors()) {
            // エラー情報をMap形式に変換してModelに追加
            Map<String, List<String>> fieldErrors = convertToFieldErrorsMap(bindingResult);
            model.addAttribute("fieldErrors", fieldErrors);

            // セレクトボックスの選択肢を再度追加
            addSelectOptions(model);

            return "formA";
        }

        // 正常処理（実際はDBへの保存処理など）
        employeeService.registerEmployee(form);

        model.addAttribute("successMessage", "登録が完了しました");
        model.addAttribute("employeeName", form.getEmployeeName());

        return "success";
    }

    /**
     * 業務ロジックチェック
     * データベースアクセスを伴うチェックを実行
     *
     * @param form フォームオブジェクト
     * @param result BindingResult
     */
    private void validateBusinessLogic(EmployeeForm form, BindingResult result) {

        // 1. メールアドレス重複チェック
        if (employeeService.existsByEmail(form.getEmail())) {
            String message = getMessage("error.emailExists");
            result.rejectValue("email", "error.emailExists", message);
        }

        // 2. 電話番号重複チェック
        if (employeeService.existsByPhoneNumber(form.getPhoneNumber())) {
            String message = getMessage("error.phoneExists");
            result.rejectValue("phoneNumber", "error.phoneExists", message);
        }

        // 3. 部署の存在チェック
        if (!employeeService.departmentExists(form.getDepartmentId())) {
            String message = getMessage("error.departmentNotFound");
            result.rejectValue("departmentId", "error.departmentNotFound", message);
        }
    }

    /**
     * BindingResultをMap<フィールド名, エラーメッセージリスト>に変換
     * FreeMarkerテンプレートで扱いやすい形式に変換
     *
     * @param bindingResult BindingResult
     * @return フィールドエラーのMap
     */
    private Map<String, List<String>> convertToFieldErrorsMap(BindingResult bindingResult) {
        Map<String, List<String>> fieldErrors = new HashMap<>();

        for (FieldError error : bindingResult.getFieldErrors()) {
            String fieldName = error.getField();

            // フィールド名が存在しない場合、新しいリストを作成
            if (!fieldErrors.containsKey(fieldName)) {
                fieldErrors.put(fieldName, new ArrayList<>());
            }

            // エラーメッセージを追加
            fieldErrors.get(fieldName).add(error.getDefaultMessage());
        }

        return fieldErrors;
    }

    /**
     * セレクトボックスの選択肢をModelに追加
     * 実際のプロジェクトではDBから取得
     *
     * @param model Model
     */
    private void addSelectOptions(Model model) {
        // 部署マスタ（実際はDBから取得）
        String[][] departments = {
                {"1", "営業部"},
                {"2", "開発部"},
                {"3", "人事部"},
                {"4", "総務部"},
                {"5", "経理部"}
        };
        model.addAttribute("departments", departments);

        // スキルマスタ
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
     *
     * @param code メッセージコード
     * @return ローカライズされたメッセージ
     */
    private String getMessage(String code) {
        return messageSource.getMessage(code, null, LocaleContextHolder.getLocale());
    }
}