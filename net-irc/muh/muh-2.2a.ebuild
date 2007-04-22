# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/muh/muh-2.2a.ebuild,v 1.3 2007/04/22 08:29:36 kloeri Exp $

DESCRIPTION="Persistent IRC bouncer"
HOMEPAGE="http://mind.riot.org/muh/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~hppa ~mips ~ppc ~sparc x86"
IUSE="ipv6"

DEPEND=""

src_compile() {
	econf --datadir=/usr/share/muh $(use_enable ipv6) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog TODO
}

pkg_postinst() {
	einfo
	einfo "You'll need to configure muh before running it."
	einfo "Put your config in ~/.muh/muhrc"
	einfo "A sample config is /usr/share/muh/muhrc"
	einfo "For more information, see the documentation."
	einfo
}
