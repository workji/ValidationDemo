<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User登録フォーム</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.0/font/bootstrap-icons.css">

    <style>
        body {
            background-color: #f8f9fa;
            padding: 20px 0;
        }
        .form-container {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            padding: 40px;
            margin-bottom: 30px;
        }
        .page-header {
            border-bottom: 3px solid #198754;
            padding-bottom: 15px;
            margin-bottom: 30px;
        }
        .section-header {
            color: #198754;
            font-size: 1.3rem;
            font-weight: 600;
            margin-top: 30px;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e9ecef;
        }
        .required-mark::after {
            content: " *";
            color: #dc3545;
            font-weight: bold;
        }
        .form-text {
            font-size: 0.875rem;
        }
        .invalid-feedback {
            display: block;
        }
    </style>
</head>
<body>

<#import "/spring.ftl" as spring />

<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="form-container">

                <div class="page-header">
                    <h1 class="h2 mb-2">
                        <i class="bi bi-person-plus-fill text-success"></i> User登録フォーム
                    </h1>
                    <p class="text-muted mb-0">
                        各項目の入力欄の直下にエラーメッセージが表示されます
                    </p>
                </div>

                <form action="/register" method="post" novalidate>

                    <!-- ========== 基本情報 ========== -->
                    <div class="section-header">
                        <i class="bi bi-person-circle"></i> 基本情報
                    </div>

                    <div class="row">

                        <!-- ユーザ名 -->
                        <div class="col-md-6 mb-3">
                            <label class="form-label required-mark">ユーザ名</label>
                            <@spring.bind "userForm.name" />
                            <input type="text"
                                   name="name"
                                   value="${spring.status.value!''}"
                                   class="form-control <#if spring.status.errorMessages?has_content>is-invalid</#if>"
                                   placeholder="山田 太郎">

                            <#list spring.status.errorMessages as msg>
                                <div class="invalid-feedback">${msg}</div>
                            </#list>
                        </div>

                        <!-- メール -->
                        <div class="col-md-6 mb-3">
                            <label class="form-label required-mark">メールアドレス</label>
                            <@spring.bind "userForm.email" />
                            <input type="email"
                                   name="email"
                                   value="${spring.status.value!''}"
                                   class="form-control <#if spring.status.errorMessages?has_content>is-invalid</#if>"
                                   placeholder="example@company.com">

                            <#if spring.status.errorMessages?has_content>
                                <#list spring.status.errorMessages as msg>
                                    <div class="invalid-feedback">${msg}</div>
                                </#list>
                            <#else>
                                <div class="form-text">業務で使用するメールアドレスを入力してください</div>
                            </#if>
                        </div>
                    </div>

                    <div class="row">

                        <!-- パスワード -->
                        <div class="col-md-6 mb-3">
                            <label class="form-label required-mark">パスワード</label>
                            <@spring.bind "userForm.password" />
                            <input type="password"
                                   name="password"
                                   class="form-control <#if spring.status.errorMessages?has_content>is-invalid</#if>">

                            <#if spring.status.errorMessages?has_content>
                                <#list spring.status.errorMessages as msg>
                                    <div class="invalid-feedback">${msg}</div>
                                </#list>
                            <#else>
                                <div class="form-text">
                                    8文字以上20文字以内、英大文字・英小文字・数字を各1文字以上含む
                                </div>
                            </#if>
                        </div>

                        <!-- パスワード確認 -->
                        <div class="col-md-6 mb-3">
                            <label class="form-label required-mark">パスワード（確認）</label>
                            <@spring.bind "userForm.confirmPassword" />
                            <input type="password"
                                   name="confirmPassword"
                                   class="form-control <#if spring.status.errorMessages?has_content>is-invalid</#if>">

                            <#list spring.status.errorMessages as msg>
                                <div class="invalid-feedback">${msg}</div>
                            </#list>
                        </div>
                    </div>

                    <!-- ボタン -->
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <button type="reset" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-counterclockwise"></i> リセット
                        </button>
                        <button type="submit" class="btn btn-success btn-lg">
                            <i class="bi bi-check-circle-fill"></i> 登録する
                        </button>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
