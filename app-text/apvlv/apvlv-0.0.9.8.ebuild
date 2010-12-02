# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/apvlv/apvlv-0.0.9.8.ebuild,v 1.2 2010/12/02 12:57:04 hwoarang Exp $

EAPI=2
inherit eutils

DESCRIPTION="Alf's PDF Viewer Like Vim"
HOMEPAGE="http://code.google.com/p/apvlv/"
SRC_URI="http://apvlv.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug djvu"

RDEPEND=">=x11-libs/gtk+-2.4:2
	>=app-text/poppler-0.12.3-r3[cairo]
	djvu? ( app-text/djvu )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_configure() {
	econf \
		$(use_enable debug) \
		--disable-dependency-tracking \
		--with-sysconfdir=/etc/${PN} \
		--with-docdir=/usr/share/doc/${PF} \
		--with-mandir=/usr/share/man \
		$(use_with djvu)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README THANKS TODO
	newicon icons/pdf.png ${PN}.png
	make_desktop_entry ${PN} "Alf's PDF Viewer Like Vim" ${PN} "Office;Viewer"
}
