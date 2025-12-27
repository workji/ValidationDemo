package com.example.demo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
class UserService {
    @Autowired
    private UserMapper userMapper;

    // 業務ロジックチェック：メールアドレスの重複確認
    public boolean isEmailRegistered(String email) {
        return userMapper.countByEmail(email) > 0;
    }

    public void register(UserForm form) {
        // 本来はパスワードハッシュ化などを行う
        userMapper.insert(form);
    }
}