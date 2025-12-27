package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Spring Boot Application Main Class
 *
 * このアプリケーションは以下の機能を提供します：
 * - FreeMarkerを使用したテンプレートレンダリング
 * - Bean Validationによる入力チェック
 * - カスタムバリデーターによる相関チェック
 * - 業務ロジックチェック
 * - エラーメッセージの国際化対応
 */

@SpringBootApplication
public class ValidationDemoApplication {

    public static void main(String[] args) {
        SpringApplication.run(ValidationDemoApplication.class, args);

        System.out.println("========================================");
        System.out.println("Application Started Successfully!");
        System.out.println("========================================");
        System.out.println("FormA (Inline Errors): http://localhost:8080/formA/register");
        System.out.println("FormB (Summary Errors): http://localhost:8080/formB/register");
        System.out.println("========================================");
    }

}
