# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/penggy/penggy-0.2.1.ebuild,v 1.4 2004/12/28 22:58:26 mrness Exp $

DESCRIPTION="Provide access to Internet using the AOL/Compuserve network."
HOMEPAGE="http://www.peng.apinc.org/eng/"
SRC_URI="ftp://ftp.penggy.org/birdy57/penggy/sources/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RDEPEND=">=dev-util/guile-1.4.0"

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

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
