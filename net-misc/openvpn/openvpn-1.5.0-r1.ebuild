# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openvpn/openvpn-1.5.0-r1.ebuild,v 1.3 2004/03/29 05:50:07 warpzero Exp $

IUSE="ssl pthreads"

S=${WORKDIR}/${P}
DESCRIPTION="OpenVPN is a robust and highly flexible tunneling application compatible with many OSes."
SRC_URI="http://easynews.dl.sourceforge.net/sourceforge/openvpn/${P}.tar.gz"
HOMEPAGE="http://openvpn.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND=">=dev-libs/lzo-1.07
	sys-kernel/linux-headers
	ssl? ( >=dev-libs/openssl-0.9.6 )"

src_compile() {

	econf \
		`use_enable ssl` \
		`use_enable ssl crypto` \
		`use_enable pthreads pthread` \
		|| die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die

	dodoc COPYING ChangeLog INSTALL PORTS README
	exeinto /etc/init.d
	doexe ${FILESDIR}/openvpn
}


pkg_postinst() {
	einfo "The init.d script that comes with OpenVPN expects directories /etc/openvpn/*/ with a local.conf and any supporting files, such as keys."
	ewarn "This version of OpenVPN is NOT COMPATIBLE with 1.4.2!"
	ewarn "If you need compatibility with 1.4.2 please emerge that version."
}
