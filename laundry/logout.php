<?php
session_start();

unset($_SESSION['id']);
unset($_SESSION['name']);


session_destroy();

header("Location: /laundry/admin/login");