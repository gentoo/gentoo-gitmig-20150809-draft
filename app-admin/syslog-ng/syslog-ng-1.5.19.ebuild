# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/syslog-ng/syslog-ng-1.5.19.ebuild,v 1.1 2002/08/18 02:44:20 blocke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Syslog-ng is a syslog replacement with advanced filtering features"
SRC_URI="http://www.balabit.hu/downloads/syslog-ng/1.5/${P}.tar.gz"
HOMEPAGE="http://www.balabit.hu/en/products/syslog-ng/"
DEPEND="virtual/glibc
		>=dev-libs/libol-0.3.3
		tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
LICENSE="GPL-2"
KEYWORDS="x86"
SLOT="0"

src_compile() {

	local myconf

	use tcpd && myconf="--enable-tcp-wrapper"

	econf ${myconf} || die

	# configure script braindamage?
    cd ${S}/src
	mv Makefile Makefile.orig
	sed -e "s|-lnsl|-lwrap|" Makefile.orig > Makefile  || die

	emake prefix=${D}/usr all || die "compile problem"
}

src_install() {

	einstall || die
	rm -rf ${D}/usr/share/man

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS PORTS README
	cd doc
	dodoc syslog-ng.conf.sample syslog-ng.conf.demo stresstest.sh
	doman syslog-ng.8 syslog-ng.conf.5
	cd ${S}/doc/sgml
	dodoc syslog-ng.dvi syslog-ng.html.tar.gz syslog-ng.ps syslog-ng.sgml syslog-ng.txt

	dodir /etc/syslog-ng
	insinto /etc/syslog-ng
	doins ${FILESDIR}/syslog-ng.conf.sample

	exeinto /etc/init.d
	newexe ${FILESDIR}/syslog-ng.rc6 syslog-ng
}
