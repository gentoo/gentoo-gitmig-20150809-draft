# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/chemical-mime-data/chemical-mime-data-0.1.94.ebuild,v 1.3 2008/05/15 19:45:11 maekke Exp $

inherit eutils fdo-mime

DESCRIPTION="A collection of data files to add support for chemical MIME types."
HOMEPAGE="http://chemical-mime.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN/-data/}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-util/pkgconfig
		x11-misc/shared-mime-info
		dev-util/intltool
		dev-util/desktop-file-utils
		dev-libs/libxslt
		media-gfx/imagemagick
		gnome-base/gnome-mime-data"

RDEPEND=""

pkg_setup() {

	if ! built_with_use 'media-gfx/imagemagick' xml; then
		eerror "media-gfx/imagemagick must be built with the xml USE-flag enabled"
		die "emerge media-gfx/imagemagick with the xml USE-flag enabled"
	fi

}

src_compile() {

	econf --disable-update-database --htmldir=/usr/share/doc/${PN}/html
	emake || die "make failed"
}

src_install() {

	make DESTDIR="${D}" install

}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	ewarn "You can ignore any 'Unknown media type in type' warnings."

}
