package com.example.demo.config;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.validation.beanvalidation.LocalValidatorFactoryBean;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.i18n.AcceptHeaderLocaleResolver;

import java.util.Locale;

/**
 * メッセージソースとバリデーション設定
 *
 * このクラスの役割：
 * 1. エラーメッセージをpropertiesファイルから読み込む設定
 * 2. 日本語・英語の切り替え対応
 * 3. Bean Validationとメッセージソースの連携
 */
@Configuration
public class MessageConfig {

    /**
     * メッセージソースの設定
     * messages.properties と messages_ja.properties を読み込む
     *
     * @return MessageSource
     */
    @Bean
    public MessageSource messageSource() {
        ReloadableResourceBundleMessageSource messageSource =
                new ReloadableResourceBundleMessageSource();

        // メッセージファイルのベース名を指定
        messageSource.setBasename("classpath:messages");

        // 文字エンコーディングをUTF-8に設定
        messageSource.setDefaultEncoding("UTF-8");

        // キャッシュを無効化（開発時のみ推奨）
        // 本番環境では適切なキャッシュ時間を設定してください
        messageSource.setCacheSeconds(-1);

        return messageSource;
    }

    /**
     * ロケールリゾルバーの設定
     * ブラウザの言語設定に基づいて自動的に言語を切り替える
     *
     * @return LocaleResolver
     */
    @Bean
    public LocaleResolver localeResolver() {
        AcceptHeaderLocaleResolver localeResolver = new AcceptHeaderLocaleResolver();

        // デフォルトロケールを日本語に設定
        localeResolver.setDefaultLocale(Locale.JAPANESE);

        return localeResolver;
    }

    /**
     * バリデーター設定
     * Bean ValidationのエラーメッセージをMessageSourceから取得できるようにする
     *
     * @return LocalValidatorFactoryBean
     */
    @Bean
    public LocalValidatorFactoryBean validator(MessageSource messageSource) {
        LocalValidatorFactoryBean bean = new LocalValidatorFactoryBean();
        bean.setValidationMessageSource(messageSource);
        return bean;
    }
}