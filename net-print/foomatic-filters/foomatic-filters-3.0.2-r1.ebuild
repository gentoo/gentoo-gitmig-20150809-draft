# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/foomatic-filters/foomatic-filters-3.0.2-r1.ebuild,v 1.2 2006/05/08 22:40:35 genstef Exp $

inherit eutils

DESCRIPTION="Foomatic wrapper scripts"
HOMEPAGE="http://www.linuxprinting.org/foomatic.html"
SRC_URI="http://www.linuxprinting.org/download/foomatic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE="samba"

DEPEND="samba? ( net-fs/samba )
	>=net-print/cups-1.1.19
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
	has_version =net-print/cups-1.2* && export CUPS=/usr/libexec/cups CUPS_FILTERS=/usr/libexec/cups/filter 
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dosym /usr/bin/foomatic-rip /usr/bin/lpdomatic

	dosym /usr/bin/foomatic-gswrapper /usr/$(get_libdir)/cups/filter/foomatic-gswrapper
	dosym /usr/bin/foomatic-rip /usr/$(get_libdir)/cups/filter/cupsomatic
	if has_version =net-print/cups-1.2*; then
		mv ${D}/usr/$(get_libdir)/cups/* ${D}/usr/libexec/cups
		rm ${D}/usr/$(get_libdir)/cups/
	fi
}
