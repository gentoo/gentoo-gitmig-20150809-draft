BEGIN { su="no"; de="no"; ve="no"; fs="no"; gm="no" }

# Keyboard settings 

/\(keyboard/ { tag="keyboard" }
/\)keyboard/ { tag="" }
$1 =="(keymap", $1 ==")keymap" { if ( tag == "keyboard" && $1 !~ /.keymap/ ) ke=$1 }
$1 =="(font", $1==")font" { if ( tag == "keyboard" && $1 !~ /.font/ ) fo=$1 }

# Login Settings

/\(login/ { tag="login" }
/\)login/ { tag="" }
/\|su/ { if ( tag == "login" ) su="yes" }
/\|delay/ { if ( tag == "login" ) de="yes" }

# Boot Settings

/\(boot/ { tag="boot" }
/\)boot/ { tag="" }
/\|verbose/ { if ( tag == "boot") ve="yes" }
/\|fsckfix/ { if ( tag == "boot") fs="yes" }

# Time Settings

/\(time/ { tag="time" }
/\)time/ { tag="" }
/\|gmt/ { if ( tag == "time" ) gm="yes" }
$1=="(zone", $1==")zone" { if ( tag == "time" && $1 !~ /.zone/ ) zo=$1 }

# OS Settings

/\(os/ { tag="os" }
/\)os/ { tag="" }
$1=="(name", $1==")name" { if ( tag == "os" && $1 !~ /.name/ ) on=$1 }
$1=="(arch", $1==")arch" { if ( tag == "os" && $1 !~ /.arch/ ) ar=$1 }
END {
  print "desc0=" on
  print "desc1=" ar
  print "KEYMAP=" ke
  print "CONSOLEFONT=" fo
  print "SULOGIN=" su
  print "DELAYLOGIN=" de
  print "VERBOSE=" ve
  print "FSCKFIX=" fs
  print "GMT=" gm
  print "TIMEZONE=" zo
}
