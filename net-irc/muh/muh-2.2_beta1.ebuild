# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/muh/muh-2.2_beta1.ebuild,v 1.4 2005/07/07 16:36:01 swegener Exp $

MY_P=${P/_/}

DESCRIPTION="Persistent IRC bouncer"
HOMEPAGE="http://mind.riot.org/muh/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"
RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips"
IUSE="ipv6"

DEPEND=""

S="${WORKDIR}"/${MY_P}

src_compile() {
	econf $(use_enable ipv6) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
	dodoc AUTHORS ChangeLog TODO
}

pkg_postinst() {
	einfo
	einfo "You'll need to configure muh before running it."
	einfo "Put your config in ~/.muh/muhrc"
	einfo "A sample config is /usr/share/muhrc"
	einfo "For more information, see the documentation."
	einfo
}
