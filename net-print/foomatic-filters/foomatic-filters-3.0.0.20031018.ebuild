# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-filters/foomatic-filters-3.0.0.20031018.ebuild,v 1.1 2003/12/31 13:04:06 lanius Exp $

MY_P=${P/3.0.0./3.0-}

DESCRIPTION="Foomatic wrapper scripts"
HOMEPAGE="http://www.linuxprinting.org/foomatic"
SRC_URI="http://www.linuxprinting.org/download/foomatic/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE="cups samba"

S=${WORKDIR}/${MY_P}

DEPEND="samba? ( net-fs/samba )
	cups? ( >=net-print/cups-1.1.19 )"

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	if [ `use cups` ]; then
		dosym /usr/bin/foomatic-gswrapper /usr/lib/cups/filter/foomatic-gswrapper
		dosym /usr/bin/foomatic-rip /usr/lib/cups/filter/cupsomatic
	fi
	dosym /usr/bin/foomatic-rip /usr/bin/lpdomatic
}
