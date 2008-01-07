# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/guifications/guifications-2.14.ebuild,v 1.8 2008/01/07 05:14:09 tester Exp $

MY_PN=pidgin-${PN}
MY_PV=${PV/_beta/beta}
MY_P=${MY_PN}-${MY_PV}
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Guifications is a graphical notification plugin for the open source instant message client pidgin"
HOMEPAGE="http://plugins.guifications.org/"
SRC_URI="http://downloads.guifications.org/plugins//Guifications2/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc sparc x86"
IUSE="debug nls"

RDEPEND="net-im/pidgin
	>=x11-libs/gtk+-2"

DEPEND="${DEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use net-im/pidgin gtk; then
		eerror "You need to compile net-im/pidgin with USE=gtk"
		die "Missing gtk USE flag on net-im/pidgin"
	fi
}

src_compile() {
	econf \
		$(use_enable debug ) \
		$(use_enable nls) || die "econf failure"
	emake || die "emake failure"
}

src_install() {
	make install DESTDIR="${D}" || die "make install failure"
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO VERSION
}
