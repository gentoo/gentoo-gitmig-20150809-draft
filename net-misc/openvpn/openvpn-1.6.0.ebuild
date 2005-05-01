# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openvpn/openvpn-1.6.0.ebuild,v 1.8 2005/05/01 09:02:35 luckyduck Exp $

inherit gnuconfig


DESCRIPTION="OpenVPN is a robust and highly flexible tunneling application compatible with many OSes."
SRC_URI="mirror://sourceforge/openvpn/${P}.tar.gz"
HOMEPAGE="http://openvpn.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~ppc-macos amd64"
IUSE="ssl threads"

RDEPEND=">=dev-libs/lzo-1.07
	ssl? ( >=dev-libs/openssl-0.9.6 )"
DEPEND="${RDEPEND} virtual/os-headers"

src_unpack() {
	unpack ${A}
	gnuconfig_update
}

src_compile() {
	econf \
		$(use_enable ssl) \
		$(use_enable ssl crypto) \
		$(use_enable threads pthread) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc ChangeLog INSTALL PORTS README
	exeinto /etc/init.d
	doexe ${FILESDIR}/openvpn
}

pkg_postinst() {
	einfo "The init.d script that comes with OpenVPN expects directories"
	einfo "/etc/openvpn/*/ with a local.conf and any supporting files,"
	einfo "such as keys."
	ewarn "This version of OpenVPN is NOT COMPATIBLE with 1.4.2!"
	ewarn "If you need compatibility with 1.4.2 please emerge that version."
}
