package com.example.demo.validator;

import com.example.demo.form.EmployeeForm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import java.time.LocalDate;
import java.time.Period;

/**
 * カスタムバリデーター
 *
// * 相関チェックや複雑なビジネスルールをここに実装
 * エラーメッセージはmessages.propertiesから取得
 */
@Component
public class EmployeeValidator implements Validator {

    @Autowired
    private MessageSource messageSource;

    @Override
    public boolean supports(Class<?> clazz) {
        return EmployeeForm.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        EmployeeForm form = (EmployeeForm) target;

        // ========== 相関チェック ==========

        // 1. パスワード確認チェック
        validatePasswordMatch(form, errors);

        // 2. 年齢と生年月日の整合性チェック
        validateAgeAndBirthDate(form, errors);

        // 3. 入社希望日のチェック
        validateDesiredStartDate(form, errors);

        // 4. 雇用形態と年齢の相関チェック
        validateEmploymentTypeAndAge(form, errors);

        // 5. スキルと希望年収の相関チェック
        validateSkillsAndSalary(form, errors);

        // 6. 利用規約の同意チェック
        validateTermsAgreement(form, errors);
    }

    /**
     * パスワード確認チェック
     */
    private void validatePasswordMatch(EmployeeForm form, Errors errors) {
        if (form.getPassword() != null && form.getPasswordConfirm() != null) {
            if (!form.getPassword().equals(form.getPasswordConfirm())) {
                String message = getMessage("error.passwordMismatch");
                errors.rejectValue("passwordConfirm", "error.passwordMismatch", message);
            }
        }
    }

    /**
     * 年齢と生年月日の整合性チェック
     */
    private void validateAgeAndBirthDate(EmployeeForm form, Errors errors) {
        if (form.getAge() != null && form.getBirthDate() != null) {
            int calculatedAge = Period.between(form.getBirthDate(), LocalDate.now()).getYears();

            // 年齢の差が1歳以上ある場合はエラー
            if (Math.abs(calculatedAge - form.getAge()) > 1) {
                String message = getMessage("error.ageNotMatchBirthDate",
                        new Object[]{calculatedAge});
                errors.rejectValue("age", "error.ageNotMatchBirthDate", message);
            }
        }
    }

    /**
     * 入社希望日のチェック（未来日付のみ）
     */
    private void validateDesiredStartDate(EmployeeForm form, Errors errors) {
        if (form.getDesiredStartDate() != null) {
            LocalDate today = LocalDate.now();

            // 過去日付はNG
            if (form.getDesiredStartDate().isBefore(today)) {
                String message = getMessage("error.startDateMustBeFuture");
                errors.rejectValue("desiredStartDate",
                        "error.startDateMustBeFuture", message);
            }

            // 3ヶ月以上先はNG
            LocalDate threeMonthsLater = today.plusMonths(3);
            if (form.getDesiredStartDate().isAfter(threeMonthsLater)) {
                String message = getMessage("error.startDateTooFar");
                errors.rejectValue("desiredStartDate",
                        "error.startDateTooFar", message);
            }
        }
    }

    /**
     * 雇用形態と年齢の相関チェック
     */
    private void validateEmploymentTypeAndAge(EmployeeForm form, Errors errors) {
        if (form.getEmploymentType() != null && form.getAge() != null) {
            // インターンは25歳以下のみ
            if ("intern".equals(form.getEmploymentType()) && form.getAge() > 25) {
                String message = getMessage("error.internAgeLimit");
                errors.rejectValue("employmentType", "error.internAgeLimit", message);
            }
        }
    }

    /**
     * スキルと希望年収の相関チェック
     */
    private void validateSkillsAndSalary(EmployeeForm form, Errors errors) {
        if (form.getSkills() != null && form.getExpectedSalary() != null) {
            int skillCount = form.getSkills().size();

            // スキルが3つ以上ある場合、最低年収500万円
            if (skillCount >= 3 && form.getExpectedSalary() < 5000000) {
                String message = getMessage("error.salaryTooLowForSkills");
                errors.rejectValue("expectedSalary",
                        "error.salaryTooLowForSkills", message);
            }
        }
    }

    /**
     * 利用規約の同意チェック
     */
    private void validateTermsAgreement(EmployeeForm form, Errors errors) {
        if (form.getAgreedToTerms() == null || !form.getAgreedToTerms()) {
            String message = getMessage("error.mustAgreeToTerms");
            errors.rejectValue("agreedToTerms", "error.mustAgreeToTerms", message);
        }
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

    /**
     * パラメータ付きメッセージを取得
     *
     * @param code メッセージコード
     * @param args メッセージパラメータ
     * @return ローカライズされたメッセージ
     */
    private String getMessage(String code, Object[] args) {
        return messageSource.getMessage(code, args, LocaleContextHolder.getLocale());
    }
}