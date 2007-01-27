# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/guifications/guifications-2.13_beta6.ebuild,v 1.1 2007/01/27 02:49:49 tester Exp $

MY_PN=gaim-${PN}
MY_PV=${PV/_beta/beta}
MY_P=${MY_PN}-${MY_PV}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Guifications is a graphical notification plugin for the open source instant message client gaim"
HOMEPAGE="http://gaim.guifications.org"
SRC_URI="http://downloads.guifications.org/gaim-plugins//Guifications2/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc"
IUSE="debug nls"

DEPEND="=net-im/gaim-2.0.0_beta6"

src_compile() {
	econf \
		$(use_enable debug ) \
		$(use_enable nls) || die "econf failure"
	emake || die "emake failure"
}

src_install() {
	make install DESTDIR=${D} || die "make install failure"
	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO VERSION
}
