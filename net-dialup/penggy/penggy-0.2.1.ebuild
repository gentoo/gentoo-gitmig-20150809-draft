# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/penggy/penggy-0.2.1.ebuild,v 1.15 2007/05/06 08:00:52 genone Exp $

inherit eutils autotools

DESCRIPTION="Provide access to Internet using the AOL/Compuserve network."
HOMEPAGE="http://savannah.nongnu.org/projects/pengfork/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-scheme/guile-1.4.0"

src_unpack() {
	unpack ${A}

	cd "${S}"
	epatch "${FILESDIR}/${P}-as-needed.patch"
	epatch "${FILESDIR}/${P}-nostrip.patch"
	eautoconf
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	newinitd "${FILESDIR}/rc_net.aol" net.aol
}

pkg_postinst() {
	elog
	elog "The penggy AOL/Compuserve IP tunneling package has been installed."
	elog
	elog "You now need to configure it by editing penggy.cfg, aol-secrets, and phonetab in /etc/penggy."
	elog "Also you will need to have tuntap, built into your kernel or compiled as a module."
	elog
	ewarn "IMPORTANT: Penggy is neither endorsed by or affiliated with AOL."
}
