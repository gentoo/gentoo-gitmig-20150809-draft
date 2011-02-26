# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/flphoto/flphoto-1.3.1-r2.ebuild,v 1.2 2011/02/26 17:12:41 signals Exp $

EAPI=3

inherit autotools eutils fdo-mime

DESCRIPTION="Basic image management and display program based on the FLTK toolkit"
HOMEPAGE="http://www.easysw.com/~mike/flphoto/"
SRC_URI="mirror://sourceforge/fltk/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="cups debug gphoto2 nls"

DEPEND="
	dev-libs/openssl
	virtual/jpeg
	media-libs/libpng
	sys-libs/zlib
	x11-libs/fltk:1.1
	x11-libs/libX11
	x11-misc/shared-mime-info
	cups? ( net-print/cups )
	gphoto2? ( media-gfx/gphoto2 )"
RDEPEND="${DEPEND}"

src_prepare() {
	epatch \
		"${FILESDIR}"/flphoto-1.3.1-glibc28.patch \
		"${FILESDIR}"/flphoto-1.3.1-linking.patch \
		"${FILESDIR}"/espmsg.patch
	eautoreconf
}

src_configure() {
	econf \
		--with-docdir=/usr/share/doc/${PF} \
		$(use_enable debug)
}

src_compile() {
	emake || die
	if use nls; then
		emake translations || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die
	if use nls; then
		emake DESTDIR="${D}" install-translations || die
	fi
	insinto /usr/share/mime/packages
	doins "${FILESDIR}"/album.xml || die
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
