# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Aron Griffis <agriffis@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/net-www/mozilla-bin/mozilla-bin-0.9.4.ebuild,v 1.1 2001/09/18 00:34:27 agriffis Exp $

A=mozilla-i686-pc-linux-gnu-0.9.4.tar.gz
DESCRIPTION="Mozilla web browser - binary build from mozilla.org"
SRC_URI=http://ftp.mozilla.org/pub/mozilla/releases/mozilla$PV/$A
HOMEPAGE=http://www.mozilla.org
PROVIDE=virtual/x11-web-browser

src_unpack() { 
    return 0
}

src_compile() {
    return 0
}

src_install() {
    mkdir -p $D/opt $D/usr/bin
    cd $D/opt || die
    unpack $A || die
    mv mozilla mozilla-bin-$PV || die
    cat <<EOF >$D/usr/bin/mozilla-bin || die
#!/bin/sh
cd /opt/mozilla-bin-$PV
exec ./run-mozilla.sh
EOF
    chmod 755 $D/usr/bin/mozilla-bin || die
}

pkg_postinst() {
    local l
    if [ -e /usr/bin/mozilla ]; then
	l=`ls -l /usr/bin/mozilla | awk '{print $NF}'`
	case "$l" in
	    mozilla-bin-*) ;;   # overwrite old mozilla-bin links
	    *) return 0 ;;      # don't overwrite anything else
	esac
    fi
    ln -sfn mozilla-bin /usr/bin/mozilla
}
