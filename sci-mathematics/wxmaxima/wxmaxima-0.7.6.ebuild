# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/wxmaxima/wxmaxima-0.7.6.ebuild,v 1.2 2008/10/12 11:06:08 markusle Exp $

WX_GTK_VER="2.8"
EAPI="2"
inherit eutils wxwidgets fdo-mime

MYP=wxMaxima-${PV}

DESCRIPTION="Graphical frontend to Maxima, using the wxWidgets toolkit."
HOMEPAGE="http://wxmaxima.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MYP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="unicode"

DEPEND=">=dev-libs/libxml2-2.5.0
	x11-libs/wxGTK:2.8"
RDEPEND="${DEPEND}
	sci-visualization/gnuplot[wxwindows]
	>=sci-mathematics/maxima-5.15.0"

S="${WORKDIR}/${MYP}"

src_prepare() {
	# consistent package names
	sed -i \
		-e "s:${datadir}/wxMaxima:${datadir}/${PN}:g" \
		Makefile.in data/Makefile.in || die "sed failed"

	sed -i \
		-e 's:share/wxMaxima:share/wxmaxima:g' \
		src/wxMaxima.cpp || die "sed failed"
}

src_configure() {
	econf \
		--enable-dnd \
		--enable-printing \
		--with-wx-config=${WX_CONFIG} \
		$(use_enable unicode unicode-glyphs)
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	doicon wxmaxima.png
	make_desktop_entry wxmaxima wxMaxima wxmaxima
	dodir /usr/share/doc/${PF}
	dosym /usr/share/${PN}/README /usr/share/doc/${PF}/README
	dodoc AUTHORS
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
