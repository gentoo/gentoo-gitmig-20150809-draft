# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslog-ng/syslog-ng-1.4.16-r2.ebuild,v 1.2 2004/02/24 08:44:24 mr_bones_ Exp $

IUSE="tcpd"

DESCRIPTION="syslog replacement with advanced filtering features"
SRC_URI="http://www.balabit.hu/downloads/syslog-ng/1.4/${P}.tar.gz"
HOMEPAGE="http://www.balabit.hu/en/products/syslog-ng/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc"

DEPEND="=dev-libs/libol-0.2.23
	sys-devel/flex
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"

PROVIDE="virtual/logger"

src_compile() {
	local myconf
	use tcpd && myconf="--enable-tcp-wrapper"
	econf ${myconf}

	emake prefix=${D}/usr all || die "compile problem"
}

src_install() {
	einstall
	rm -rf ${D}/usr/share/man

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS PORTS README
	dodoc doc/{syslog-ng.conf.sample,syslog-ng.conf.demo,stresstest.sh}
	doman doc/{syslog-ng.8,syslog-ng.conf.5}
	dodoc doc/sgml/{syslog-ng.dvi,syslog-ng.html.tar.gz,syslog-ng.ps,syslog-ng.sgml,syslog-ng.txt}

	insinto /etc/syslog-ng
	doins ${FILESDIR}/syslog-ng.conf.sample

	exeinto /etc/init.d
	newexe ${FILESDIR}/syslog-ng.rc6 syslog-ng
}

pkg_postinst() {
	einfo "A sample configuration file can be found in /etc/syslog-ng."
}
