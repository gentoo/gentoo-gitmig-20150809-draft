# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dialup/penggy/penggy-0.2.1.ebuild,v 1.2 2003/10/29 05:20:01 spyderous Exp $

DESCRIPTION="Provide access to Internet using the AOL/Compuserve network."
HOMEPAGE="http://www.peng.apinc.org/"
SRC_URI="ftp://ftp.penggy.org/birdy57/penggy/sources/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND=">=dev-util/guile-1.4.0"

src_compile() {
	# Without localstatedir=/var, it would use /usr/var/run/ .
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--localstatedir=/var \
		--mandir=/usr/share/man \
		--sysconfdir=/etc || die "./configure failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
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
	einfo "IMPORTANT: Penggy is neither endorsed by or affiliated with"
	einfo "AOL."
	einfo
}
