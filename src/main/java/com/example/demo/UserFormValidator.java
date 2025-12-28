package com.example.demo;

import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

@Service
class UserFormValidator implements Validator {

    @Override
    public boolean supports(Class<?> clazz) {
        return UserForm.class.isAssignableFrom(clazz);
    }

    @Override
    public void validate(Object target, Errors errors) {
        UserForm form = (UserForm) target;

        // 相関チェックロジック：パスワードと確認用パスワードの一致
        if (form.getPassword() != null && form.getConfirmPassword() != null) {
            if (!form.getPassword().equals(form.getConfirmPassword())) {
                // 特定のフィールドにエラーを紐づける
                errors.rejectValue("confirmPassword", "Unmatch", "パスワードが一致しません");
                errors.rejectValue("password", "Unmatch", "パスワードが一致しません");
            }
        }
    }
}