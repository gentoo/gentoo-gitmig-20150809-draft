# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmap/nmap-3.75.ebuild,v 1.1 2004/10/19 11:23:09 spock Exp $

inherit eutils

DESCRIPTION="A utility for network exploration or security auditing"
HOMEPAGE="http://www.insecure.org/nmap/"
SRC_URI="http://www.insecure.org/nmap/dist/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~arm ~hppa ~amd64 ~ppc64"
IUSE="gtk gnome ipv6"

DEPEND="virtual/libc
	dev-libs/libpcre
	gtk? ( =x11-libs/gtk+-1.2* )"

src_compile() {
	econf `use_with gtk nmapfe` \
		`use_enable ipv6` || die
	emake -j1 || die
}

src_install() {
	einstall nmapdatadir=${D}/usr/share/nmap install || die
	use gnome || rm -rf ${D}/usr/share/gnome/

	dodoc CHANGELOG HACKING INSTALL docs/README docs/*.txt
	dohtml docs/*.html
}
