# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/cpudyn/cpudyn-0.4.7.ebuild,v 1.4 2003/12/24 09:45:38 trance Exp $

DESCRIPTION="A daemon to control laptop power consumption via cpufreq and disk standby"
HOMEPAGE="http://mnm.uib.es/~gallir/${PN}/"
SRC_URI="http://mnm.uib.es/~gallir/${PN}/download/${P}.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"
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
	cat ${FILESDIR}/cpudyn.conf.extra >>debian/cpudyn.conf
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
