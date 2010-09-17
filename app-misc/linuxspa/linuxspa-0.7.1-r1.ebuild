# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/linuxspa/linuxspa-0.7.1-r1.ebuild,v 1.1 2010/09/17 04:32:13 jer Exp $

EAPI="2"

inherit eutils toolchain-funcs

MY_PN="LinuxSPA"
DESCRIPTION="Linux Serial Protocol Analyser"
HOMEPAGE="http://sourceforge.net/projects/serialsniffer/"
SRC_URI="mirror://sourceforge/serialsniffer/${MY_PN}-0.7.1.tgz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-compile-fix.patch
	sed -i Makefile \
		-e 's| -o | $(LDFLAGS)&|g' \
		|| die "sed Makefile"
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -Wall" \
		LDFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dobin LinuxSPA std232
	dodoc ASCII_Filter.txt BCircuit.txt LinuxSPA.png READING_Materials.txt \
		README TODO connector-1a.ps connector-2a.ps cooked.file raw.file
}
