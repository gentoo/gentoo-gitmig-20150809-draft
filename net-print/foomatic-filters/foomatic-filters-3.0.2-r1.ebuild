# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-filters/foomatic-filters-3.0.2-r1.ebuild,v 1.10 2006/10/19 16:38:08 vapier Exp $

inherit eutils

DESCRIPTION="Foomatic wrapper scripts"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://www.linuxprinting.org/download/foomatic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="cups samba"

DEPEND="samba? ( net-fs/samba )
	cups? ( >=net-print/cups-1.1.19 )
	|| (
		app-text/enscript
		net-print/cups
		app-text/a2ps
		app-text/mpage
	)
	virtual/ghostscript
	!<net-print/foomatic-db-20050910"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Search for libs in ${libdir}, not just /usr/lib
	epatch ${FILESDIR}/${P}-multilib.patch
	autoconf || die "autoconf failed"
}

src_compile() {
	export CUPS=$(cups-config --serverbin) CUPS_FILTERS=$(cups-config --serverbin)/filter
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dosym /usr/bin/foomatic-rip /usr/bin/lpdomatic

	if use cups; then
		dosym /usr/bin/foomatic-gswrapper $(cups-config --serverbin)/filter/foomatic-gswrapper
		dosym /usr/bin/foomatic-rip $(cups-config --serverbin)/filter/cupsomatic
	else
		rm -r ${D}/$(cups-config --serverbin)/filter
	fi
}
