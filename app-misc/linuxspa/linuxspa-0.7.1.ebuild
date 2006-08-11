# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/linuxspa/linuxspa-0.7.1.ebuild,v 1.3 2006/08/11 19:32:25 chrb Exp $

inherit eutils
DESCRIPTION="Linux Serial Protocol Analyser"
HOMEPAGE="http://sourceforge.net/projects/serialsniffer/"
SRC_URI="mirror://sourceforge/serialsniffer/LinuxSPA-0.7.1.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""
DEPEND="virtual/libc"
MY_PN="LinuxSPA"
S=${WORKDIR}/${MY_PN}

src_unpack() {
	unpack ${A}
	sed -i -e "s/CFLAGS\W*=.*/CFLAGS = ${CFLAGS}/" ${S}/Makefile
	cd ${S}
	epatch ${FILESDIR}/${P}-compile-fix.patch
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dobin LinuxSPA std232
	insinto /usr/share/doc/${P}
	doins ASCII_Filter.txt BCircuit.txt LinuxSPA.png READING_Materials.txt
	doins README TODO connector-1a.ps connector-2a.ps cooked.file raw.file
}
