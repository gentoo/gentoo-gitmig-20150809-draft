# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libexif-gtk/libexif-gtk-0.3.5-r1.ebuild,v 1.3 2007/03/21 15:59:27 armin76 Exp $

inherit eutils

DESCRIPTION="GTK+ frontend to the libexif library (parsing, editing, and saving EXIF data)"
HOMEPAGE="http://libexif.sf.net"
SRC_URI="mirror://sourceforge/libexif/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc sparc x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2
	>=media-libs/libexif-0.6.12"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-confcheck.patch"
}

src_compile() {
	econf $(use_enable nls)
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog
}
