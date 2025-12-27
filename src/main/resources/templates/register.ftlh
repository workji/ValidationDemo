<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ユーザー登録</title>
    <style>
        .error { color: red; font-size: 0.9em; }
        .form-group { margin-bottom: 15px; }
        label { display: inline-block; width: 150px; }
        input { padding: 5px; }
    </style>
</head>
<body>

<h2>ユーザー登録</h2>

<#-- 修正ポイント: RequestParametersの代わりに springMacroRequestContext.queryString を判定するか、
     直接パラメータの存在を確認します。?? は変数が存在するかをチェックする記号です -->
<#if (springMacroRequestContext.getQueryString()?? && springMacroRequestContext.getQueryString()?contains("success"))>
    <div style="color: green; margin-bottom: 20px;">登録が完了しました！</div>
</#if>

<form action="/register" method="post">
    <div class="form-group">
        <label for="name">お名前:</label>
        <#assign nameStatus = springMacroRequestContext.getBindStatus("userForm.name")>
        <input type="text" id="name" name="name" value="${nameStatus.value!''}">
        <#if nameStatus.error>
            <div class="error">
                <#list nameStatus.errorMessages as msg>
                    ${msg}<br>
                </#list>
            </div>
        </#if>
    </div>

    <div class="form-group">
        <label for="email">メールアドレス:</label>
        <#assign emailStatus = springMacroRequestContext.getBindStatus("userForm.email")>
        <input type="text" id="email" name="email" value="${emailStatus.value!''}">
        <#if emailStatus.error>
            <div class="error">
                <#list emailStatus.errorMessages as msg>
                    ${msg}<br>
                </#list>
            </div>
        </#if>
    </div>

    <div class="form-group">
        <label for="password">パスワード:</label>
        <#assign passwordStatus = springMacroRequestContext.getBindStatus("userForm.password")>
        <input type="password" id="password" name="password">
        <#if passwordStatus.error>
            <div class="error">
                <#list passwordStatus.errorMessages as msg>
                    ${msg}<br>
                </#list>
            </div>
        </#if>
    </div>

    <div class="form-group">
        <label for="confirmPassword">パスワード(確認):</label>
        <#assign confirmStatus = springMacroRequestContext.getBindStatus("userForm.confirmPassword")>
        <input type="password" id="confirmPassword" name="confirmPassword">
        <#if confirmStatus.error>
            <div class="error">
                <#list confirmStatus.errorMessages as msg>
                    ${msg}<br>
                </#list>
            </div>
        </#if>
    </div>

    <button type="submit">登録する</button>
</form>

</body>
</html>