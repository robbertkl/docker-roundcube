<?php

$config = array();

$config['db_dsnw'] = 'sqlite:////var/www/db/sqlite.db';

$config['imap_conn_options'] =
$config['smtp_conn_options'] =
$config['managesieve_conn_options'] = [
    'ssl' => [
        'verify_peer' => false,
        'verify_peer_name' => false,
        'allow_self_signed' => true,
    ],
];

$config['default_port'] = 143;

$config['smtp_port'] = 587;
$config['smtp_user'] = '%u';
$config['smtp_pass'] = '%p';

$config['plugins'] = array('carddav', 'managesieve');
if(getenv('ROUNDCUBE_USER_FILE')) $config['plugins'][] = 'password';
