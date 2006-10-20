# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-4.11.ebuild,v 1.9 2006/10/20 21:56:20 kloeri Exp $

inherit eutils flag-o-matic

DESCRIPTION="A utility for network exploration or security auditing"
HOMEPAGE="http://www.insecure.org/nmap/"
SRC_URI="http://download.insecure.org/nmap/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc-macos ppc64 s390 sh sparc ~x86 ~x86-fbsd"
IUSE="gtk ssl"

DEPEND="virtual/libc
	dev-libs/libpcre
	gtk? ( =x11-libs/gtk+-2* )
	ssl? ( dev-libs/openssl )"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed 's:Icon=icon-network:Icon=nmap-logo-64.png:' -i nmapfe.desktop
	echo ";" >> nmapfe.desktop
	epatch ${FILESDIR}/nmap-shtool-nls.patch
	epatch ${FILESDIR}/nmap-4.01-nostrip.patch
}

src_compile() {
	use ppc-macos && filter-flags -fstrict-aliasing -O2
	econf \
		$(use_with gtk nmapfe) \
		$(use_with ssl openssl) || die
	emake -j1 || die
}

src_install() {
	einstall -j1 nmapdatadir=${D}/usr/share/nmap install || die
	dodoc CHANGELOG HACKING docs/README docs/*.txt
	dohtml docs/*.html

	if use gtk; then
		dodir /usr/share/pixmaps
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/nmap-logo-64.png
	fi
}
