<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>従業員登録フォーム（サマリーエラー方式）</title>

    <!-- Bootstrap 5 CSS -->
    <link href="/bootstrap/css/bootstrap.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="/bootstrap-icons/bootstrap-icons.css">

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
            border-bottom: 3px solid #0d6efd;
            padding-bottom: 15px;
            margin-bottom: 30px;
        }

        .section-header {
            color: #0d6efd;
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

        .error-summary {
            animation: slideDown 0.3s ease-out;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .error-item {
            padding: 8px 0;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .error-item:last-child {
            border-bottom: none;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="row justify-content-center">
        <div class="col-lg-10">
            <div class="form-container">
                <div class="page-header">
                    <h1 class="h2 mb-2">
                        <i class="bi bi-person-plus-fill text-primary"></i> 従業員登録フォーム
                    </h1>
                    <p class="text-muted mb-0">エラーがある場合、画面上部に全エラーがまとめて表示されます</p>
                </div>

                <!-- エラーサマリー -->
                <#if errorMessages?? && (errorMessages?size > 0)>
                    <div class="alert alert-danger alert-dismissible fade show error-summary" role="alert">
                        <h5 class="alert-heading">
                            <i class="bi bi-exclamation-triangle-fill"></i> 入力内容にエラーがあります（${errorMessages?size}件）
                        </h5>
                        <hr>
                        <ul class="mb-0">
                            <#list errorMessages as error>
                                <li class="error-item">
                                    <strong>${error.fieldName}:</strong> ${error.message}
                                </li>
                            </#list>
                        </ul>
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </#if>

                <form action="/formB/register" method="post" novalidate>

                    <!-- ========== 基本情報 ========== -->
                    <div class="section-header">
                        <i class="bi bi-person-circle"></i> 基本情報
                    </div>

                    <!-- 従業員名 -->
                    <div class="mb-3">
                        <label for="employeeName" class="form-label required-mark">従業員名</label>
                        <input type="text"
                               class="form-control"
                               id="employeeName"
                               name="employeeName"
                               value="${(employeeForm.employeeName)!''}"
                               placeholder="山田 太郎">
                    </div>

                    <!-- メールアドレス -->
                    <div class="mb-3">
                        <label for="email" class="form-label required-mark">メールアドレス</label>
                        <input type="email"
                               class="form-control"
                               id="email"
                               name="email"
                               value="${(employeeForm.email)!''}"
                               placeholder="example@company.com">
                        <div class="form-text">業務で使用するメールアドレスを入力してください</div>
                    </div>

                    <!-- 電話番号 -->
                    <div class="mb-3">
                        <label for="phoneNumber" class="form-label required-mark">電話番号</label>
                        <input type="text"
                               class="form-control"
                               id="phoneNumber"
                               name="phoneNumber"
                               value="${(employeeForm.phoneNumber)!''}"
                               placeholder="09012345678">
                        <div class="form-text">ハイフンなしで10桁または11桁の数字を入力</div>
                    </div>

                    <div class="row">
                        <!-- 郵便番号 -->
                        <div class="col-md-4 mb-3">
                            <label for="postalCode" class="form-label required-mark">郵便番号</label>
                            <input type="text"
                                   class="form-control"
                                   id="postalCode"
                                   name="postalCode"
                                   value="${(employeeForm.postalCode)!''}"
                                   placeholder="1234567">
                            <div class="form-text">7桁の数字</div>
                        </div>

                        <!-- 住所 -->
                        <div class="col-md-8 mb-3">
                            <label for="address" class="form-label required-mark">住所</label>
                            <input type="text"
                                   class="form-control"
                                   id="address"
                                   name="address"
                                   value="${(employeeForm.address)!''}"
                                   placeholder="東京都渋谷区〇〇1-2-3">
                        </div>
                    </div>

                    <div class="row">
                        <!-- 生年月日 -->
                        <div class="col-md-6 mb-3">
                            <label for="birthDate" class="form-label required-mark">生年月日</label>
                            <input type="date"
                                   class="form-control"
                                   id="birthDate"
                                   name="birthDate"
                                   value="${(employeeForm.birthDate)!''}">
                        </div>

                        <!-- 年齢 -->
                        <div class="col-md-6 mb-3">
                            <label for="age" class="form-label required-mark">年齢</label>
                            <input type="number"
                                   class="form-control"
                                   id="age"
                                   name="age"
                                   value="${(employeeForm.age)!''}"
                                   min="18"
                                   max="70">
                            <div class="form-text">18歳以上70歳以下</div>
                        </div>
                    </div>

                    <!-- 性別 -->
                    <div class="mb-3">
                        <label class="form-label required-mark">性別</label>
                        <div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input"
                                       type="radio"
                                       name="gender"
                                       id="gender_male"
                                       value="male"
                                       <#if (employeeForm.gender)! == 'male'>checked</#if>>
                                <label class="form-check-label" for="gender_male">男性</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input"
                                       type="radio"
                                       name="gender"
                                       id="gender_female"
                                       value="female"
                                       <#if (employeeForm.gender)! == 'female'>checked</#if>>
                                <label class="form-check-label" for="gender_female">女性</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input"
                                       type="radio"
                                       name="gender"
                                       id="gender_other"
                                       value="other"
                                       <#if (employeeForm.gender)! == 'other'>checked</#if>>
                                <label class="form-check-label" for="gender_other">その他</label>
                            </div>
                        </div>
                    </div>

                    <!-- ========== 雇用情報 ========== -->
                    <div class="section-header">
                        <i class="bi bi-briefcase-fill"></i> 雇用情報
                    </div>

                    <!-- 雇用形態 -->
                    <div class="mb-3">
                        <label class="form-label required-mark">雇用形態</label>
                        <div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input"
                                       type="radio"
                                       name="employmentType"
                                       id="emp_fulltime"
                                       value="fulltime"
                                       <#if (employeeForm.employmentType)! == 'fulltime'>checked</#if>>
                                <label class="form-check-label" for="emp_fulltime">正社員</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input"
                                       type="radio"
                                       name="employmentType"
                                       id="emp_parttime"
                                       value="parttime"
                                       <#if (employeeForm.employmentType)! == 'parttime'>checked</#if>>
                                <label class="form-check-label" for="emp_parttime">パート・アルバイト</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input"
                                       type="radio"
                                       name="employmentType"
                                       id="emp_contract"
                                       value="contract"
                                       <#if (employeeForm.employmentType)! == 'contract'>checked</#if>>
                                <label class="form-check-label" for="emp_contract">契約社員</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input"
                                       type="radio"
                                       name="employmentType"
                                       id="emp_intern"
                                       value="intern"
                                       <#if (employeeForm.employmentType)! == 'intern'>checked</#if>>
                                <label class="form-check-label" for="emp_intern">インターン</label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- 部署 -->
                        <div class="col-md-6 mb-3">
                            <label for="departmentId" class="form-label required-mark">部署</label>
                            <select class="form-select"
                                    id="departmentId"
                                    name="departmentId">
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
                        <div class="col-md-6 mb-3">
                            <label for="position" class="form-label required-mark">役職</label>
                            <select class="form-select"
                                    id="position"
                                    name="position">
                                <option value="">-- 選択してください --</option>
                                <option value="manager" <#if (employeeForm.position)! == 'manager'>selected</#if>>マネージャー</option>
                                <option value="leader" <#if (employeeForm.position)! == 'leader'>selected</#if>>リーダー</option>
                                <option value="member" <#if (employeeForm.position)! == 'member'>selected</#if>>メンバー</option>
                                <option value="intern" <#if (employeeForm.position)! == 'intern'>selected</#if>>インターン</option>
                            </select>
                        </div>
                    </div>

                    <!-- スキル -->
                    <div class="mb-3">
                        <label class="form-label required-mark">スキル（複数選択可）</label>
                        <div class="row">
                            <#if skillOptions??>
                                <#list skillOptions as skill>
                                    <div class="col-md-4 col-sm-6">
                                        <div class="form-check">
                                            <input class="form-check-input"
                                                   type="checkbox"
                                                   id="skill_${skill[0]}"
                                                   name="skills"
                                                   value="${skill[0]}"
                                                   <#if employeeForm.skills?? && employeeForm.skills?seq_contains(skill[0])>checked</#if>>
                                            <label class="form-check-label" for="skill_${skill[0]}">${skill[1]}</label>
                                        </div>
                                    </div>
                                </#list>
                            </#if>
                        </div>
                        <div class="form-text">少なくとも1つ選択してください</div>
                    </div>

                    <div class="row">
                        <!-- 希望年収 -->
                        <div class="col-md-6 mb-3">
                            <label for="expectedSalary" class="form-label required-mark">希望年収（円）</label>
                            <input type="number"
                                   class="form-control"
                                   id="expectedSalary"
                                   name="expectedSalary"
                                   value="${(employeeForm.expectedSalary)!''}"
                                   step="100000"
                                   placeholder="5000000">
                            <div class="form-text">300万円以上2000万円以下</div>
                        </div>

                        <!-- 入社希望日 -->
                        <div class="col-md-6 mb-3">
                            <label for="desiredStartDate" class="form-label required-mark">入社希望日</label>
                            <input type="date"
                                   class="form-control"
                                   id="desiredStartDate"
                                   name="desiredStartDate"
                                   value="${(employeeForm.desiredStartDate)!''}">
                            <div class="form-text">本日以降3ヶ月以内</div>
                        </div>
                    </div>

                    <!-- 面接希望時刻 -->
                    <div class="mb-3">
                        <label for="interviewTime" class="form-label required-mark">面接希望時刻</label>
                        <input type="time"
                               class="form-control"
                               id="interviewTime"
                               name="interviewTime"
                               value="${(employeeForm.interviewTime)!''}"
                               style="max-width: 300px;">
                        <div class="form-text">営業時間: 9:00 - 18:00</div>
                    </div>

                    <!-- ========== アカウント情報 ========== -->
                    <div class="section-header">
                        <i class="bi bi-shield-lock-fill"></i> アカウント情報
                    </div>

                    <div class="row">
                        <!-- パスワード -->
                        <div class="col-md-6 mb-3">
                            <label for="password" class="form-label required-mark">パスワード</label>
                            <input type="password"
                                   class="form-control"
                                   id="password"
                                   name="password">
                            <div class="form-text">8文字以上20文字以内、英大文字・英小文字・数字を各1文字以上含む</div>
                        </div>

                        <!-- パスワード確認 -->
                        <div class="col-md-6 mb-3">
                            <label for="passwordConfirm" class="form-label required-mark">パスワード（確認）</label>
                            <input type="password"
                                   class="form-control"
                                   id="passwordConfirm"
                                   name="passwordConfirm">
                        </div>
                    </div>

                    <!-- ========== その他 ========== -->
                    <div class="section-header">
                        <i class="bi bi-chat-left-text-fill"></i> その他
                    </div>

                    <!-- 自己PR -->
                    <div class="mb-3">
                        <label for="selfIntroduction" class="form-label">自己PR</label>
                        <textarea class="form-control"
                                  id="selfIntroduction"
                                  name="selfIntroduction"
                                  rows="5"
                                  placeholder="あなたの強みや経験をアピールしてください">${(employeeForm.selfIntroduction)!''}</textarea>
                        <div class="form-text">500文字以内</div>
                    </div>

                    <!-- 利用規約 -->
                    <div class="mb-4">
                        <div class="form-check">
                            <input class="form-check-input"
                                   type="checkbox"
                                   id="agreedToTerms"
                                   name="agreedToTerms"
                                   value="true"
                                   <#if (employeeForm.agreedToTerms)!false>checked</#if>>
                            <label class="form-check-label required-mark" for="agreedToTerms">
                                利用規約に同意する
                            </label>
                        </div>
                    </div>

                    <!-- ボタン -->
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <button type="reset" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-counterclockwise"></i> リセット
                        </button>
                        <button type="submit" class="btn btn-primary btn-lg">
                            <i class="bi bi-check-circle-fill"></i> 登録する
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="/bootstrap/js/bootstrap.bundle.js"></script>
</body>
</html>