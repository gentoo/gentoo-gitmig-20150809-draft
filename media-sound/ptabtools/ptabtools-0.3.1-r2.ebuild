# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/ptabtools/ptabtools-0.3.1-r2.ebuild,v 1.3 2007/06/19 23:11:58 angelos Exp $

inherit eutils toolchain-funcs multilib

MY_PV=${PV%.*}-${PV##*.}

DESCRIPTION="A set of utilities to use powertab files (.ptb)"
HOMEPAGE="http://jelmer.vernstok.nl/oss/ptabtools/"
SRC_URI="http://jelmer.vernstok.nl/releases/${PN}_${MY_PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-libs/popt
	dev-libs/libxml2
	dev-libs/libxslt
	=dev-libs/glib-2*"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}-${PV%.*}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-fPIC.patch"
	epatch "${FILESDIR}/${P}-respectflags.patch"
	epatch "${FILESDIR}/${P}-soname.patch"
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/man/man1
	dodir /usr/$(get_libdir)/pkgconfig
	dodir /usr/include
	dodoc AUTHORS ChangeLog README TODO

	sed -i -e "s:/usr/local:/usr:; s:-lptb:-lptb-0.2:" ptabtools.pc
	einstall libdir="${D}/usr/$(get_libdir)" || die
}
