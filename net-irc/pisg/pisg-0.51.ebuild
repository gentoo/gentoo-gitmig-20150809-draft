# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/pisg/pisg-0.51.ebuild,v 1.1 2004/02/11 23:45:28 zul Exp $

DESCRIPTION="Perl IRC Statistics Generator"
HOMEPAGE="http://pisg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

IUSE=""

DEPEND="dev-lang/perl"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i 's!lang\.txt!/usr/share/pisg/lang.txt!' modules/Pisg.pm
	sed -i 's!layout/!/usr/share/pisg/layout/!' modules/Pisg.pm
}

src_install () {
	eval `perl -V:installprivlib`

	dobin pisg

	dodir ${installprivlib}
	cp -r modules/* ${D}/${installprivlib}

	dodir /usr/share/pisg
	cp -r gfx layout lang.txt ${D}/usr/share/pisg

	dodoc docs/CREDITS docs/Changelog docs/FORMATS docs/pisg-doc.txt
	dodoc docs/dev/API pisg.cfg COPYING README
	dohtml docs/html/*
}

pkg_postinst() {
	einfo
	einfo "The pisg images have been installed in /usr/share/pisg/gfx"
	einfo
}
