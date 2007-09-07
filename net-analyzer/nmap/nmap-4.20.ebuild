# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-4.20.ebuild,v 1.15 2007/09/07 23:16:58 spock Exp $

inherit eutils flag-o-matic

DESCRIPTION="A utility for network exploration or security auditing"
HOMEPAGE="http://www.insecure.org/nmap/"
SRC_URI="http://download.insecure.org/nmap/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="gtk ssl"

DEPEND="dev-libs/libpcre
	net-libs/libpcap
	gtk? ( =x11-libs/gtk+-2* )
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed 's:Icon=icon-network:Icon=nmap-logo-64.png:' -i nmapfe.desktop
	echo ";" >> nmapfe.desktop
	epatch "${FILESDIR}/nmap-shtool-nls.patch"
	epatch "${FILESDIR}/nmap-4.01-nostrip.patch"
	epatch "${FILESDIR}/${P}-osscan.patch"
}

src_compile() {
	use ppc-macos && filter-flags -fstrict-aliasing -O2
	econf \
		--with-libdnet=included \
		$(use_with gtk nmapfe) \
		$(use_with ssl openssl) || die
	emake -j1 || die
}

src_install() {
	einstall -j1 nmapdatadir=${D}/usr/share/nmap install || die
	dodoc CHANGELOG HACKING docs/README docs/*.txt || die

	use gtk && doicon "${FILESDIR}/nmap-logo-64.png"
}
