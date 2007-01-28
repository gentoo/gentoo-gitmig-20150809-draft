# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/picptk/picptk-0.5a-r1.ebuild,v 1.2 2007/01/28 17:21:26 calchan Exp $

WANT_AUTOMAKE="1.4"
WANT_AUTOCONF="latest"

inherit eutils autotools

DESCRIPTION="Picptk is a programmer supporting the whole PIC family including all memory types (EEPROM, EPROM, and OTP)"
HOMEPAGE="http://huizen.dds.nl/~gnupic/programmers_mike_butler.html"
SRC_URI="http://huizen.dds.nl/~gnupic/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="=dev-tcltk/itk-3.3*
	dev-tcltk/iwidgets
	dev-tcltk/itcl"

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}"/${PF}-headerfix.patch
	epatch "${FILESDIR}"/${PF}-gccfixes.patch
	cd "${S}"
	sed -i.orig -e '49,53d' \
		-e 's/AM_PROG_INSTALL/AC_PROG_INSTALL/g' \
		${S}/aclocal.m4 || die "sed failed"
	eautoreconf || die "autoreconf failed"
}

src_compile() {
	econf LDFLAGS="-L/usr/lib/itk3.3 ${LDFLAGS}" || die "Configuration failed"
	emake || die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS NEWS README TODO
	newdoc .picprc sample.picprc
}
