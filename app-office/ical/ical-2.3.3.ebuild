# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/ical/ical-2.3.3.ebuild,v 1.1 2009/01/17 02:25:28 mescalinum Exp $

WANT_AUTOCONF=latest

inherit autotools eutils multilib

DESCRIPTION="Tk-based Calendar program"
HOMEPAGE="http://www.fnal.gov/docs/products/tktools/ical.html"
SRC_URI="http://annexia.org/_file/${P}.tar.gz"

LICENSE="as-is GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RESTRICT="test"

DEPEND="dev-lang/tcl
	dev-lang/tk"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s:mkdir:mkdir -p:" \
		-e "/LIBDIR =/s:lib:$(get_libdir):" \
		-e "/MANDIR =/s:man:share/man:" \
		Makefile.in || die

	epatch "${FILESDIR}"/${P}-tcl8.5.patch
	eautoconf
	cd "${S}/types"; eautoconf
}

src_compile() {
	econf || die "econf failed"
	emake OPTF="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "emake failed"
}

src_install() {
	emake prefix="${D}/usr" install || die "emake install failed"

	dodoc ANNOUNCE README *.txt
	dohtml CHANGES.html doc/*.html
}
