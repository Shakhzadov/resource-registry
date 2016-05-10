<?php

$params = require(__DIR__ . '/params.php');

$config = [
    'id' => 'basic',
    'basePath' => dirname(__DIR__),
    'bootstrap' => ['log'],
    'modules' => [
        'auth' => [
            'passwordResetTokenExpire' => 3600 // Seconds for token expiration
        ],
    ],
    'components' => [
        'authcomponent' => [
            'class' => 'app\components\AuthComponent',
        ],
        'request' => [
            // !!! insert a secret key in the following (if it is empty) - this is required by cookie validation
            'cookieValidationKey' => 'FbkQPfmLc5XQkHBgXYQ2Ymd_J3jz8Faw',
            'parsers' => [
                'application/json' => 'yii\web\JsonParser',
            ],
        ],
        'urlManager' => [
            'enablePrettyUrl' => true,
            'enableStrictParsing' => true,
            'showScriptName' => false,
            'rules' => [
                [
                    'class' => 'yii\rest\UrlRule',
                    'controller' => ['user', 'resource', 'user_role_view',
                        'resource_class', 'resource_attribute',
                        'personal_data', 'parameter',
                        'operation_type', 'operation', 'attribute_class_view', 'search',
                        'community', 'request'
                    ], 'extraPatterns' => [
                    'GET search' => 'search',
                    'POST login' => 'login',
                    'POST adduser' => 'adduser',
                    'POST restorepass' => 'restorepass',
                    'POST changepass' => 'changepass',
                    'GET logout' => 'logout',
                    'GET show' => 'show',
                    'GET showrequest' => 'showrequest',
                    'GET {id}/export' => 'export',
                    'GET getregisterkey' => 'getregisterkey',
                    'GET getresourcebycoordinate' => 'getresourcebycoordinate',
                    'POST getuser' => 'getuser',
                    'POST addcomm' => 'addcomm',
                    'GET userdata' => 'userdata',
                    'GET changerole' => 'changerole',
                    'GET changeactivationstatus' => 'changeactivationstatus',
                    'GET getrole' => 'getrole',
                    'GET changeactivationstatus2' => 'changeactivationstatus2',
                    ],
                ],
            ],
        ],
        'cache' => [
            'class' => 'yii\caching\FileCache',
        ],
        'user' => [
            'identityClass' => 'app\models\User',
            'enableAutoLogin' => true,
        ],
        'errorHandler' => [
            'errorAction' => 'site/error',
        ],
        'mailer' => [
            'class' => 'yii\swiftmailer\Mailer',
            // send all mails to a file by default. You have to set
            // 'useFileTransport' to false and configure a transport
            // for the mailer to send real emails.
            'useFileTransport' => false,
            'transport' => [
                'class' => 'Swift_SmtpTransport',
                'host' => 'smtp.gmail.com',
                'username' => 'testmailthx@gmail.com',
                'password' => '199145war',
                'port' => '465',
                'encryption' => 'ssl',
            ],
        ],
        'log' => [
            'traceLevel' => YII_DEBUG ? 3 : 0,
            'targets' => [
                [
                    'class' => 'yii\log\FileTarget',
                    'levels' => ['error', 'warning'],
                ],
            ],
        ],
        'db' => require(__DIR__ . '/db.php'),


    ],
    'params' => $params,
];

if (YII_ENV_DEV) {
    // configuration adjustments for 'dev' environment
    $config['bootstrap'][] = 'debug';
    $config['modules']['debug'] = [
        'class' => 'yii\debug\Module',
    ];

    $config['bootstrap'][] = 'gii';
    $config['modules']['gii'] = [
        'class' => 'yii\gii\Module',
    ];
}

return $config;
