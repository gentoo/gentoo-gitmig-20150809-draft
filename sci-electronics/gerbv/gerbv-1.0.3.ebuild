# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-electronics/gerbv/gerbv-1.0.3.ebuild,v 1.2 2008/01/10 10:45:08 calchan Exp $

DESCRIPTION="A free Gerber viewer"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://gerbv.sourceforge.net/"

IUSE="doc examples png unit-mm"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

RDEPEND="=x11-libs/gtk+-2*
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

src_compile() {
	econf \
		--disable-dependency-tracking \
		--enable-gtk2 \
		$(use_enable png exportpng ) \
		$(use_enable unit-mm ) \
		--with-maxfiles=50 \
		|| die "Configuration failed"
	emake || die "Compilation failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "Installation failed"
	dodoc AUTHORS ChangeLog CONTRIBUTORS HACKING NEWS README TODO

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
