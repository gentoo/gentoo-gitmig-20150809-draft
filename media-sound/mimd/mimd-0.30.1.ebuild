# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mimd/mimd-0.30.1.ebuild,v 1.2 2005/03/19 01:11:59 swegener Exp $

DESCRIPTION="Multicast streaming server for MPEG1/2 and MP3 files."

HOMEPAGE="http://darkwing.uoregon.edu/~tkay/mim.html"
SRC_URI="http://darkwing.uoregon.edu/~tkay/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="sys-apps/sed
		>=media-plugins/live-2004.03.05
		dev-libs/xerces-c
		dev-lang/perl"

src_compile() {
	sed -e 's!@PREFIX@!/!' -e 's!@LIVEDIR@!/usr/lib/live!' -e 's!@XERCESDIR@!/usr!' < ${S}/Makefile.in > ${S}/Makefile
	emake || die
}

src_install() {
	exeinto /usr/bin
	doexe ${S}/mimd
	dodoc ${S}/doc/mimd.pod

	if [ -x /usr/bin/pod2html ]; then
		pod2html < ${S}/doc/mimd.pod > ${S}/doc/mimd.html
		dohtml ${S}/doc/mimd.html
	fi

	if [ -x /usr/bin/pod2man ]; then
		pod2man < ${S}/doc/mimd.pod > ${S}/doc/mimd.1
		doman ${S}/doc/mimd.1
	fi

	insinto /usr/share/mimd
	doins ${S}/etc/mimd.dtd ${S}/etc/sample.xml
}

pkg_postinst() {
	einfo "Please read the documentation (mimd.html or man mimd) for "
	einfo "instructions on configuring mimd. The DTD for the configuration "
	einfo "files is in /usr/share/mimd/mimd.dtd, along with a sample "
	einfo "configuration file (/usr/share/mimd/sample.xml)."
	ewarn "NOTE: You must have ip multicasting enabled in the kernel for this"
	ewarn "daemon to work properly."
}
