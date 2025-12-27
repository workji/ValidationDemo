<!DOCTYPE html>
<html lang="ja">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>登録完了</title>

    <!-- Bootstrap 5 CSS -->
    <link href="/bootstrap/css/bootstrap.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="/bootstrap-icons/bootstrap-icons.css">

    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .success-container {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            padding: 50px;
            max-width: 600px;
            text-align: center;
            animation: slideUp 0.5s ease-out;
        }

        @keyframes slideUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .success-icon {
            font-size: 80px;
            color: #28a745;
            margin-bottom: 20px;
            animation: scaleIn 0.5s ease-out 0.2s both;
        }

        @keyframes scaleIn {
            from {
                transform: scale(0);
            }
            to {
                transform: scale(1);
            }
        }

        .success-title {
            font-size: 2rem;
            font-weight: bold;
            color: #333;
            margin-bottom: 15px;
        }

        .success-message {
            color: #666;
            font-size: 1.1rem;
            margin-bottom: 30px;
        }

        .employee-name {
            font-size: 1.5rem;
            color: #667eea;
            font-weight: bold;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<div class="success-container">
    <div class="success-icon">
        <i class="bi bi-check-circle-fill"></i>
    </div>

    <h1 class="success-title">${successMessage!'登録完了'}</h1>

    <div class="employee-name">
        <i class="bi bi-person-badge"></i> ${employeeName!''}様
    </div>

    <p class="success-message">
        従業員情報の登録が正常に完了しました。<br>
        ご登録いただきありがとうございます。
    </p>

    <div class="d-grid gap-2 d-md-flex justify-content-md-center">
        <a href="/formA/register" class="btn btn-success btn-lg">
            <i class="bi bi-plus-circle"></i> 新規登録（フォームA）
        </a>
        <a href="/formB/register" class="btn btn-primary btn-lg">
            <i class="bi bi-plus-circle"></i> 新規登録（フォームB）
        </a>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="/bootstrap/js/bootstrap.bundle.js"></script>
</body>
</html>