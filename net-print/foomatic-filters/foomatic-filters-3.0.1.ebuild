# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-filters/foomatic-filters-3.0.1.ebuild,v 1.10 2004/07/17 17:27:50 tgall Exp $

DESCRIPTION="Foomatic wrapper scripts"
HOMEPAGE="http://www.linuxprinting.org/foomatic"
SRC_URI="http://www.linuxprinting.org/download/foomatic/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha hppa amd64 ~ia64 ~mips ppc64"
IUSE="cups samba"

DEPEND="samba? ( net-fs/samba )
	cups? ( >=net-print/cups-1.1.19 )
	virtual/ghostscript"

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	if use cups; then
		dosym /usr/bin/foomatic-gswrapper /usr/lib/cups/filter/foomatic-gswrapper
		dosym /usr/bin/foomatic-rip /usr/lib/cups/filter/cupsomatic
	fi
	dosym /usr/bin/foomatic-rip /usr/bin/lpdomatic
}
