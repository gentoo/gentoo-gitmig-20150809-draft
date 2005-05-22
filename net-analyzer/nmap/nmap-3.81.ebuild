# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-3.81.ebuild,v 1.9 2005/05/22 16:43:46 dertobi123 Exp $

inherit eutils

DESCRIPTION="A utility for network exploration or security auditing"
HOMEPAGE="http://www.insecure.org/nmap/"
SRC_URI="http://www.insecure.org/nmap/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ppc ~ppc-macos ppc64 ~s390 sparc x86"
IUSE="gtk ssl"

DEPEND="virtual/libc
	dev-libs/libpcre
	gtk? ( =x11-libs/gtk+-1.2* )
	ssl? ( dev-libs/openssl )"

src_compile() {
	econf \
		$(use_with gtk nmapfe) \
		$(use_with ssl openssl) || die
	emake -j1 || die
}

src_install() {
	einstall -j1 nmapdatadir=${D}/usr/share/nmap install || die
	dodoc CHANGELOG HACKING INSTALL docs/README docs/*.txt
	dohtml docs/*.html
}
