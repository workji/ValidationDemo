<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>従業員登録フォーム（サマリーエラー方式）</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            max-width: 800px;
            margin: 40px auto;
            padding: 20px;
            background-color: #f5f5f5;
        }

        .container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        h1 {
            color: #333;
            border-bottom: 3px solid #2196F3;
            padding-bottom: 10px;
        }

        /* エラーサマリー */
        .error-summary {
            background-color: #ffebee;
            border-left: 5px solid #f44336;
            padding: 20px;
            margin-bottom: 30px;
            border-radius: 4px;
        }

        .error-summary h3 {
            color: #f44336;
            margin-top: 0;
            margin-bottom: 15px;
        }

        .error-list {
            list-style-type: none;
            padding: 0;
            margin: 0;
        }

        .error-list li {
            padding: 8px 0;
            border-bottom: 1px solid #ffcdd2;
        }

        .error-list li:last-child {
            border-bottom: none;
        }

        .error-field-name {
            font-weight: bold;
            color: #d32f2f;
        }

        .error-message-text {
            color: #666;
            margin-left: 10px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #555;
        }

        .required::after {
            content: " *";
            color: red;
        }

        input[type="text"],
        input[type="email"],
        input[type="number"],
        input[type="date"],
        input[type="time"],
        input[type="password"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .radio-group,
        .checkbox-group {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .radio-item,
        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        input[type="radio"],
        input[type="checkbox"] {
            width: auto;
            margin: 0;
        }

        .button-group {
            margin-top: 30px;
            display: flex;
            gap: 10px;
        }

        button {
            padding: 12px 30px;
            border: none;
            border-radius: 4px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .btn-submit {
            background-color: #2196F3;
            color: white;
        }

        .btn-submit:hover {
            background-color: #1976D2;
        }

        .btn-reset {
            background-color: #f44336;
            color: white;
        }

        .btn-reset:hover {
            background-color: #da190b;
        }

        .help-text {
            font-size: 12px;
            color: #888;
            margin-top: 5px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1>従業員登録フォーム（サマリーエラー方式）</h1>
    <p style="color: #666;">エラーがある場合、画面上部に全エラーがまとめて表示されます</p>

    <!-- エラーサマリー -->
    <#if errorMessages?? && (errorMessages?size > 0)>
        <div class="error-summary">
            <h3>⚠ 入力内容にエラーがあります（${errorMessages?size}件）</h3>
            <ul class="error-list">
                <#list errorMessages as error>
                    <li>
                        <span class="error-field-name">[${error.fieldName}]</span>
                        <span class="error-message-text">${error.message}</span>
                    </li>
                </#list>
            </ul>
        </div>
    </#if>

    <form action="/formB/register" method="post">

        <h2 style="color: #2196F3; margin-top: 30px;">基本情報</h2>

        <!-- 従業員名 -->
        <div class="form-group">
            <label class="required">従業員名</label>
            <input type="text"
                   name="employeeName"
                   value="${(employeeForm.employeeName)!''}"
                   placeholder="山田 太郎">
        </div>

        <!-- メールアドレス -->
        <div class="form-group">
            <label class="required">メールアドレス</label>
            <input type="email"
                   name="email"
                   value="${(employeeForm.email)!''}"
                   placeholder="example@company.com">
            <span class="help-text">業務で使用するメールアドレスを入力してください</span>
        </div>

        <!-- 電話番号 -->
        <div class="form-group">
            <label class="required">電話番号</label>
            <input type="text"
                   name="phoneNumber"
                   value="${(employeeForm.phoneNumber)!''}"
                   placeholder="09012345678">
            <span class="help-text">ハイフンなしで10桁または11桁の数字を入力</span>
        </div>

        <!-- 郵便番号 -->
        <div class="form-group">
            <label class="required">郵便番号</label>
            <input type="text"
                   name="postalCode"
                   value="${(employeeForm.postalCode)!''}"
                   placeholder="1234567">
            <span class="help-text">ハイフンなしで7桁の数字を入力</span>
        </div>

        <!-- 住所 -->
        <div class="form-group">
            <label class="required">住所</label>
            <input type="text"
                   name="address"
                   value="${(employeeForm.address)!''}"
                   placeholder="東京都渋谷区〇〇1-2-3">
        </div>

        <!-- 生年月日 -->
        <div class="form-group">
            <label class="required">生年月日</label>
            <input type="date"
                   name="birthDate"
                   value="${(employeeForm.birthDate)!''}">
        </div>

        <!-- 年齢 -->
        <div class="form-group">
            <label class="required">年齢</label>
            <input type="number"
                   name="age"
                   value="${(employeeForm.age)!''}"
                   min="18"
                   max="70">
            <span class="help-text">18歳以上70歳以下</span>
        </div>

        <!-- 性別 -->
        <div class="form-group">
            <label class="required">性別</label>
            <div class="radio-group">
                <div class="radio-item">
                    <input type="radio"
                           id="gender_male"
                           name="gender"
                           value="male"
                           <#if (employeeForm.gender)! == 'male'>checked</#if>>
                    <label for="gender_male" style="font-weight: normal; margin: 0;">男性</label>
                </div>
                <div class="radio-item">
                    <input type="radio"
                           id="gender_female"
                           name="gender"
                           value="female"
                           <#if (employeeForm.gender)! == 'female'>checked</#if>>
                    <label for="gender_female" style="font-weight: normal; margin: 0;">女性</label>
                </div>
                <div class="radio-item">
                    <input type="radio"
                           id="gender_other"
                           name="gender"
                           value="other"
                           <#if (employeeForm.gender)! == 'other'>checked</#if>>
                    <label for="gender_other" style="font-weight: normal; margin: 0;">その他</label>
                </div>
            </div>
        </div>

        <h2 style="color: #2196F3; margin-top: 30px;">雇用情報</h2>

        <!-- 雇用形態 -->
        <div class="form-group">
            <label class="required">雇用形態</label>
            <div class="radio-group">
                <div class="radio-item">
                    <input type="radio"
                           id="emp_fulltime"
                           name="employmentType"
                           value="fulltime"
                           <#if (employeeForm.employmentType)! == 'fulltime'>checked</#if>>
                    <label for="emp_fulltime" style="font-weight: normal; margin: 0;">正社員</label>
                </div>
                <div class="radio-item">
                    <input type="radio"
                           id="emp_parttime"
                           name="employmentType"
                           value="parttime"
                           <#if (employeeForm.employmentType)! == 'parttime'>checked</#if>>
                    <label for="emp_parttime" style="font-weight: normal; margin: 0;">パート・アルバイト</label>
                </div>
                <div class="radio-item">
                    <input type="radio"
                           id="emp_contract"
                           name="employmentType"
                           value="contract"
                           <#if (employeeForm.employmentType)! == 'contract'>checked</#if>>
                    <label for="emp_contract" style="font-weight: normal; margin: 0;">契約社員</label>
                </div>
                <div class="radio-item">
                    <input type="radio"
                           id="emp_intern"
                           name="employmentType"
                           value="intern"
                           <#if (employeeForm.employmentType)! == 'intern'>checked</#if>>
                    <label for="emp_intern" style="font-weight: normal; margin: 0;">インターン</label>
                </div>
            </div>
        </div>

        <!-- 部署 -->
        <div class="form-group">
            <label class="required">部署</label>
            <select name="departmentId">
                <option value="">-- 選択してください --</option>
                <#if departments??>
                    <#list departments as dept>
                        <option value="${dept[0]}"
                                <#if (employeeForm.departmentId)?? && employeeForm.departmentId?string == dept[0]>selected</#if>>
                            ${dept[1]}
                        </option>
                    </#list>
                </#if>
            </select>
        </div>

        <!-- 役職 -->
        <div class="form-group">
            <label class="required">役職</label>
            <select name="position">
                <option value="">-- 選択してください --</option>
                <option value="manager" <#if (employeeForm.position)! == 'manager'>selected</#if>>マネージャー</option>
                <option value="leader" <#if (employeeForm.position)! == 'leader'>selected</#if>>リーダー</option>
                <option value="member" <#if (employeeForm.position)! == 'member'>selected</#if>>メンバー</option>
                <option value="intern" <#if (employeeForm.position)! == 'intern'>selected</#if>>インターン</option>
            </select>
        </div>

        <!-- スキル -->
        <div class="form-group">
            <label class="required">スキル（複数選択可）</label>
            <div class="checkbox-group">
                <#if skillOptions??>
                    <#list skillOptions as skill>
                        <div class="checkbox-item">
                            <input type="checkbox"
                                   id="skill_${skill[0]}"
                                   name="skills"
                                   value="${skill[0]}"
                                   <#if employeeForm.skills?? && employeeForm.skills?seq_contains(skill[0])>checked</#if>>
                            <label for="skill_${skill[0]}" style="font-weight: normal; margin: 0;">${skill[1]}</label>
                        </div>
                    </#list>
                </#if>
            </div>
            <span class="help-text">少なくとも1つ選択してください</span>
        </div>

        <!-- 希望年収 -->
        <div class="form-group">
            <label class="required">希望年収（円）</label>
            <input type="number"
                   name="expectedSalary"
                   value="${(employeeForm.expectedSalary)!''}"
                   step="100000"
                   placeholder="5000000">
            <span class="help-text">300万円以上2000万円以下</span>
        </div>

        <!-- 入社希望日 -->
        <div class="form-group">
            <label class="required">入社希望日</label>
            <input type="date"
                   name="desiredStartDate"
                   value="${(employeeForm.desiredStartDate)!''}">
            <span class="help-text">本日以降3ヶ月以内の日付を選択</span>
        </div>

        <!-- 面接希望時刻 -->
        <div class="form-group">
            <label class="required">面接希望時刻</label>
            <input type="time"
                   name="interviewTime"
                   value="${(employeeForm.interviewTime)!''}">
            <span class="help-text">営業時間: 9:00 - 18:00</span>
        </div>

        <h2 style="color: #2196F3; margin-top: 30px;">アカウント情報</h2>

        <!-- パスワード -->
        <div class="form-group">
            <label class="required">パスワード</label>
            <input type="password" name="password">
            <span class="help-text">8文字以上20文字以内、英大文字・英小文字・数字を各1文字以上含む</span>
        </div>

        <!-- パスワード確認 -->
        <div class="form-group">
            <label class="required">パスワード（確認）</label>
            <input type="password" name="passwordConfirm">
        </div>

        <h2 style="color: #2196F3; margin-top: 30px;">その他</h2>

        <!-- 自己PR -->
        <div class="form-group">
            <label>自己PR</label>
            <textarea name="selfIntroduction"
                      placeholder="あなたの強みや経験をアピールしてください">${(employeeForm.selfIntroduction)!''}</textarea>
            <span class="help-text">500文字以内</span>
        </div>

        <!-- 利用規約への同意 -->
        <div class="form-group">
            <div class="checkbox-item">
                <input type="checkbox"
                       id="agreedToTerms"
                       name="agreedToTerms"
                       value="true"
                       <#if (employeeForm.agreedToTerms)!false>checked</#if>>
                <label for="agreedToTerms" class="required" style="font-weight: normal; margin: 0;">
                    利用規約に同意する
                </label>
            </div>
        </div>

        <div class="button-group">
            <button type="submit" class="btn-submit">登録する</button>
            <button type="reset" class="btn-reset">リセット</button>
        </div>
    </form>
</div>
</body>
</html>