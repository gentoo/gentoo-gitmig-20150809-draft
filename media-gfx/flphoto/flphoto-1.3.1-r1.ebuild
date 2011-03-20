# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/flphoto/flphoto-1.3.1-r1.ebuild,v 1.7 2011/03/20 20:14:56 jlec Exp $

EAPI=1

inherit eutils fdo-mime

DESCRIPTION="Basic image management and display program based on the FLTK toolkit"
HOMEPAGE="http://www.easysw.com/~mike/flphoto/"
SRC_URI="mirror://sourceforge/fltk/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="cups gphoto2"

DEPEND="
	dev-libs/openssl
	virtual/jpeg
	media-libs/libpng
	sys-libs/zlib
	x11-libs/fltk:1
	x11-libs/libX11
	x11-misc/shared-mime-info
	cups? ( net-print/cups )
	gphoto2? ( media-gfx/gphoto2 )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/flphoto-1.3.1-glibc28.patch
	### Patch to fix segfault on PowerPC
	epatch "${FILESDIR}"/espmsg.patch
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
