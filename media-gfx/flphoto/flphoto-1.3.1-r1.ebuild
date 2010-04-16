# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/flphoto/flphoto-1.3.1-r1.ebuild,v 1.4 2010/04/16 18:47:46 hwoarang Exp $

EAPI=1

inherit eutils fdo-mime

DESCRIPTION="Basic image management and display program based on the FLTK toolkit"
HOMEPAGE="http://www.easysw.com/~mike/flphoto/"
SRC_URI="mirror://sourceforge/fltk/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="cups gphoto2"

DEPEND=">=x11-libs/fltk-1.1.4:1.1
	cups? ( net-print/cups )
	gphoto2? ( media-gfx/gphoto2 )
	x11-misc/shared-mime-info
	dev-libs/openssl
	media-libs/jpeg
	media-libs/libpng
	sys-libs/zlib
	x11-libs/libX11"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/flphoto-1.3.1-glibc28.patch
}

src_compile() {
	econf --with-docdir=/usr/share/doc/${PF} || die
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install || die
	insinto /usr/share/mime/packages
	doins "${FILESDIR}"/album.xml
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
