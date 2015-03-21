<?php

function sortByScore($a, $b)
{
    return $a['score'] - $b['score'];
}

if($_GET['nick'] && $_GET['score'] && is_numeric($_GET['score']))
{
    $s = file_get_contents('data');

    $e = explode("\n", $s);

    $table = array();

    $_GET['nick'] = str_replace(' ', '', $_GET['nick']);

    $table[] = array('nick' => $_GET['nick'], 'score' => $_GET['score']);

    foreach((array)$e as $line)
    {
        $e2 = explode(' ', $line);
        $nick = $e2[0];
        $score = $e2[1];
        $table[] = array('nick' => $nick, 'score' => $score);

    }

    usort($table, 'sortByScore');
    $table = array_reverse($table);

    $out = "";
    foreach((array)$table as $n)
    {
        $out .= $n['nick'].' '.$n['score']."\n";
    }

    $out = preg_replace("/(^[\r\n]*|[\r\n]+)[\s\t]*[\r\n]+/", "", $out);

    file_put_contents('data', $out);

}
else
{
    $s = file_get_contents('data');
    echo $s;
}

