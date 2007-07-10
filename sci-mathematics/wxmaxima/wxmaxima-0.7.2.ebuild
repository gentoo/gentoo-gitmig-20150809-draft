# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/wxmaxima/wxmaxima-0.7.2.ebuild,v 1.2 2007/07/10 03:35:55 nerdboy Exp $

inherit eutils autotools wxwidgets fdo-mime

MYP=wxMaxima-${PV}

DESCRIPTION="Graphical frontend to Maxima, using the wxWidgets toolkit."
HOMEPAGE="http://wxmaxima.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MYP}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="unicode"
DEPEND=">=dev-libs/libxml2-2.5.0
	>=x11-libs/wxGTK-2.6"
RDEPEND=">=sci-mathematics/maxima-5.11.0"

S=${WORKDIR}/${MYP}

src_compile () {
	export WX_GTK_VER="2.6"
	if use unicode; then
		need-wxwidgets unicode
	else
		need-wxwidgets gtk2
	fi

	# consistent package names
	sed -i \
		-e 's:COPYING::' \
		-e "s:${datadir}/wxMaxima:${datadir}/${PN}:g" \
		Makefile.in data/Makefile.in || die "sed failed"

	sed -i \
		-e 's:share/wxMaxima:share/wxmaxima:g' \
		src/wxMaxima.cpp || die "sed failed"

	econf \
		--enable-dnd \
		--enable-printing \
		--with-wx-config=${WX_CONFIG} \
		$(use_unicode unicode-glyphs) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"
	newicon maxima-new.png wxmaxima.png
	make_desktop_entry wxmaxima "wxMaxima ${PV}" wxmaxima \
	    "Science;Math;Education"

	dosym ${PORTDIR}/licenses/${LICENSE} /usr/share/${PN}/COPYING
	dodir /usr/share/doc/${PF}
	dosym /usr/share/${PN}/README /usr/share/doc/${PF}/README
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
