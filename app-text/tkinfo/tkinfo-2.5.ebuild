# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Ben Lutgens <blutgens@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-text/tkinfo/tkinfo-2.5.ebuild,v 1.1 2001/06/15 18:18:21 blutgens Exp $

#P=
A=${P}.tar.gz
S=${WORKDIR}/${P}
DESCRIPTION="Info Browser in TK"
SRC_URI="http://math-www.uni-paderborn.de/~axel/tkinfo/${A}"
HOMEPAGE="http://math-www.uni-paderborn.de/~axel/tkinfo/"

DEPEND=">=dev-lang/tcl-tk-8.0.5"


src_install () {

    dobin tkinfo
    doman tkinfo.1
    dodoc README

}

pkg_postinst () {

# Let's check to see if info has been setup completely
cd /usr/share/info
if [ -f dir ]; then
	exit 0;
else
	mkinfodir . > dir
fi
}

