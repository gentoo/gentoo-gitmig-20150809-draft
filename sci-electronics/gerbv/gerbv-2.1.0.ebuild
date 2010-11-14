# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gerbv/gerbv-2.1.0.ebuild,v 1.2 2010/11/14 17:26:48 armin76 Exp $

inherit fdo-mime

DESCRIPTION="A free Gerber viewer"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gerbv.sourceforge.net/"

IUSE="cairo doc examples png unit-mm"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="=x11-libs/gtk+-2*
	cairo? ( x11-libs/cairo )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

src_unpack() {
	unpack ${A}
	sed -i -e 's/Education/Application/' "${S}"/desktop/gerbv.desktop || die "sed failed"
}

src_compile() {
	econf \
		--disable-dependency-tracking \
		--disable-update-desktop-database \
		$(use_enable cairo ) \
		$(use_enable png exportpng ) \
		$(use_enable unit-mm ) \
		--with-maxfiles=50 \
		|| die "Configuration failed"
	emake || die "Compilation failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS ChangeLog CONTRIBUTORS HACKING NEWS README* TODO

	if use doc
	then
		find doc -name "Makefile*" -exec rm -f '{}' \;
		find doc -name "*.txt" -exec ecompress '{}' \;
		insinto /usr/share/doc/${PF}
		doins -r doc/*
	fi

	if use examples
	then
		find example -name "Makefile*" -exec rm -f '{}' \;
		find example -name "*.txt" -exec ecompress '{}' \;
		insinto /usr/share/doc/${PF}/examples
		doins -r example/*
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
