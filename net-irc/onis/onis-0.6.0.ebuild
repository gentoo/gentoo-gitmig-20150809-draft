# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/onis/onis-0.6.0.ebuild,v 1.3 2004/07/30 00:03:54 swegener Exp $

inherit eutils

DESCRIPTION="onis not irc stats"
HOMEPAGE="http://verplant.org/onis/"
SRC_URI="http://verplant.org/${PN}/${P}.tar.bz2"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-nochdir.patch

	sed -i -e s:lang/:/usr/share/onis/lang/: config
}

src_install () {
	eval `perl -V:installprivlib`

	dobin onis

	dodir ${installprivlib}
	cp -R lib/Onis ${D}/${installprivlib}

	dodir /usr/share/onis
	cp -R lang reports/* ${D}/usr/share/onis

	dodoc CHANGELOG README THANKS config users.conf
}

pkg_postinst() {
	einfo
	einfo "The onis themes have been installed in /usr/share/onis/*-theme"
	einfo "You can find a sample configuration at /usr/share/doc/${PF}/config.gz"
	einfo
}
