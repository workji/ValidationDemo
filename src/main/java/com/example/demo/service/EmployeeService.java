package com.example.demo.service;

import org.springframework.stereotype.Service;

/**
 * 従業員サービス
 *
 * 業務ロジックとデータベースアクセスを担当
 * 実際のプロジェクトではMyBatisを使ってDBアクセスを実装
 */
@Service
public class EmployeeService {

    /**
     * メールアドレスの重複チェック
     *
     * 実際のプロジェクトではMyBatisで以下のようなSQLを実行：
     * SELECT COUNT(*) FROM employees WHERE email = #{email}
     *
     * @param email メールアドレス
     * @return 既に存在する場合true
     */
    public boolean existsByEmail(String email) {
        // デモ用：特定のメールアドレスを既存とみなす
        return "test@example.com".equals(email) ||
                "admin@example.com".equals(email);
    }

    /**
     * 電話番号の重複チェック
     *
     * 実際のプロジェクトではMyBatisで以下のようなSQLを実行：
     * SELECT COUNT(*) FROM employees WHERE phone_number = #{phoneNumber}
     *
     * @param phoneNumber 電話番号
     * @return 既に存在する場合true
     */
    public boolean existsByPhoneNumber(String phoneNumber) {
        // デモ用：特定の電話番号を既存とみなす
        return "09012345678".equals(phoneNumber);
    }

    /**
     * 部署の存在チェック
     *
     * 実際のプロジェクトではMyBatisで以下のようなSQLを実行：
     * SELECT COUNT(*) FROM departments WHERE id = #{departmentId}
     *
     * @param departmentId 部署ID
     * @return 存在する場合true
     */
    public boolean departmentExists(Integer departmentId) {
        // デモ用：1〜5の部署IDのみ有効
        return departmentId != null && departmentId >= 1 && departmentId <= 5;
    }

    /**
     * 従業員を登録する
     *
     * 実際のプロジェクトではMyBatisで以下のようなSQLを実行：
     * INSERT INTO employees (employee_name, email, ...) VALUES (...)
     *
     * @param form 従業員フォーム
     * @return 登録成功の場合true
     */
    public boolean registerEmployee(Object form) {
        // デモ用：常に成功とする
        // 実際はDBへの登録処理を実装
        return true;
    }
}