# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/cupsddk/cupsddk-1.2.3.ebuild,v 1.7 2010/03/11 21:12:31 sping Exp $

inherit autotools eutils

DESCRIPTION="A suite of standard drivers, a PPD file compiler, and other utilities to develop printer drivers for CUPS 1.2.x and 1.3.x and other printing environments."
HOMEPAGE="http://www.cups.org/software.php#USING_DDK"
SRC_URI="ftp://ftp.easysw.com/pub/${PN}/${PV}/${P}-source.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"
IUSE="fltk"

DEPEND=">=net-print/cups-1.2
	fltk? ( =x11-libs/fltk-1.1* )"
RDEPEND="${DEPEND}"

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# disable prestripping of compiled binaries
	sed -i -e "/INSTALL_BIN/s/-s//" Makedefs.in || die "sed failed"

	# fix automagic fltk dependency
	epatch "${FILESDIR}"/${P}-fltk-automagic.patch
	eautoconf
}

src_compile() {
	econf BUILDROOT="${D}" \
		--with-docdir=/usr/share/doc/${PF} \
		$(use_with fltk) \
		|| die "econf failed"
	emake BUILDROOT="${D}" || die "emake failed"
}

src_install() {
	emake BUILDROOT="${D}" install || die "emake install failed"
	keepdir /usr/share/cups/drv

	rm -f LICENSE.* doc/Makefile
	dodoc *.txt
	dohtml -r doc/*
}
