# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpudyn/cpudyn-0.4.7.ebuild,v 1.1 2003/10/22 01:17:54 robbat2 Exp $

DESCRIPTION="A daemon to control laptop power consumption via cpufreq and disk standby"
HOMEPAGE="http://mnm.uib.es/~gallir/${PN}/"
SRC_URI="http://mnm.uib.es/~gallir/${PN}/download/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
S=${WORKDIR}/${PN}

src_compile() {
	emake cpudynd || die "Compilation failed."
}

src_install() {
	into /
	exeinto /etc/init.d
	newexe ${FILESDIR}/cpudyn.init cpudyn
	insinto /etc/conf.d
	newins debian/cpudyn.conf cpudyn

	into /usr
	doman cpudynd.8
	dosbin cpudynd
	dodoc INSTALL README VERSION changelog COPYING
	dohtml *.html
}

pkg_postinst() {
	einfo "Configuration file is /etc/conf.d/cpudyn."
}
