#!/bin/sh
# Copyright (c) 1999 Fumitoshi UKAI <ukai@debian.or.jp>
# Copyright (c) 1999 Jacobo Tarrio Barreiro <jtarrio@iname.com>
# This program is covered by the GNU General Public License version 2
# $Header: /var/cvsroot/gentoo-x86/net-www/w3m/files/w3m.sh,v 1.1 2003/10/04 20:20:40 usata Exp $
#

W3M=/usr/bin/w3m-en
eval `locale`
locale=${LC_ALL:-$LANG}
case X"$locale" in
  Xja|Xja_JP|Xja_JP.*)
    [ -x /usr/bin/w3m-ja ] && W3M=/usr/bin/w3m-ja
    ;;
 *)
    ;;
esac
exec $W3M "$@"
