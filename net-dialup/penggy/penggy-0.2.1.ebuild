# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/penggy/penggy-0.2.1.ebuild,v 1.8 2006/02/23 23:15:10 spyderous Exp $

DESCRIPTION="Provide access to Internet using the AOL/Compuserve network."
HOMEPAGE="None available"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=dev-util/guile-1.4.0"

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	exeinto /etc/init.d
	newexe ${FILESDIR}/rc_net.aol net.aol
}

pkg_postinst() {
	einfo
	einfo "The penggy AOL/Compuserve IP tunneling package has been installed."
	einfo
	einfo "You now need to configure it by editing penggy.cfg, aol-secrets, and phonetab in /etc/penggy."
	einfo "Also you will need to have tuntap, built into your kernel or compiled as a module."
	einfo
	ewarn "IMPORTANT: Penggy is neither endorsed by or affiliated with AOL."
}
