<?php

class rcube_file_password
{
    function save($curpass, $passwd)
    {
        $userfile = getenv('ROUNDCUBE_USER_FILE');
        $user = $_SESSION['username'];

        $salt = sha1(rand());
        $salt = substr($salt, 0, 4);
        $hash = '{SSHA}' . base64_encode(sha1($passwd . $salt, true) . $salt);

        $content = file_get_contents($userfile);
        $content = preg_replace('/^' . preg_quote($user, '/') . ':.*$/m', "{$user}:{$hash}", $content, 1, $count);

        if($count != 1)
            return PASSWORD_ERROR;

        $result = file_put_contents($userfile, $content);
        return $result === false ? PASSWORD_ERROR : PASSWORD_SUCCESS;
    }
}
