# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/pisg/pisg-0.61.ebuild,v 1.2 2004/11/12 18:16:17 blubb Exp $

inherit eutils

DESCRIPTION="Perl IRC Statistics Generator"
HOMEPAGE="http://pisg.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""

RDEPEND="dev-lang/perl
	dev-perl/Text-Iconv"
DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/0.56-network-option-fix.patch

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

	dodoc \
		docs/{CREDITS,Changelog,FORMATS,pisg-doc.txt} \
		docs/dev/API pisg.cfg README
	dohtml docs/html/*

	find ${D}/usr/{lib,share} -type d -exec chmod 755 {} \;
	find ${D}/usr/{lib,share} -type f -exec chmod 644 {} \;
}

pkg_postinst() {
	einfo
	einfo "The pisg images have been installed in /usr/share/pisg/gfx"
	einfo
}
