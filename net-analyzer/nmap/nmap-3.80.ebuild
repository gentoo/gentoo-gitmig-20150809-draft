# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-3.80.ebuild,v 1.4 2005/06/26 18:15:29 j4rg0n Exp $

inherit eutils flag-o-matic

DESCRIPTION="A utility for network exploration or security auditing"
HOMEPAGE="http://www.insecure.org/nmap/"
SRC_URI="http://www.insecure.org/nmap/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~arm hppa ~amd64 ~ppc64 ~s390 ~ia64 ~ppc-macos"
IUSE="gtk gnome ipv6"

DEPEND="virtual/libc
	dev-libs/libpcre
	gtk? ( =x11-libs/gtk+-1.2* )"

src_compile() {
	use ppc-macos && filter-flags -fstrict-aliasing -O2
	econf `use_with gtk nmapfe` \
		`use_enable ipv6` || die
	emake -j1 || die
}

src_install() {
	einstall -j1 nmapdatadir=${D}/usr/share/nmap install || die
	use gnome || rm -rf ${D}/usr/share/gnome/

	dodoc CHANGELOG HACKING INSTALL docs/README docs/*.txt
	dohtml docs/*.html
}
