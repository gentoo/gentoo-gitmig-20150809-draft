# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmmemmon/wmmemmon-0.7.0.ebuild,v 1.1 2002/10/03 15:03:16 raker Exp $

S=${WORKDIR}/${P}

DESCRIPTION="A program to monitor memory/swap usages."
SRC_URI="http://www.sh.rim.or.jp/~ssato/src/${P}.tar.gz"
HOMEPAGE="http://www.sh.rim.or.jp/~ssato/dockapp/index.shtml#wmmemmon"

LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"
SLOT="0"

DEPEND="virtual/glibc x11-base/xfree"
RDEPEND="${DEPEND}"

src_compile() {

	econf || die "configure failed"

	emake || die "parallel make failed"

}

src_install () {

	einstall || die "make install failed"

        doman doc/wmmemmon.1

        dodoc AUTHORS THANKS TODO Changelog README

        dobin src/wmmemmon

}

