# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/beast/beast-0.7.1.ebuild,v 1.1 2007/02/27 22:56:12 aballier Exp $

inherit eutils flag-o-matic fdo-mime

IUSE="debug mad static"

DESCRIPTION="BEAST - the Bedevilled Sound Engine"
HOMEPAGE="http://beast.gtk.org"
SRC_URI="ftp://beast.gtk.org/pub/beast/v${PV%.[0-9]}/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
KEYWORDS="~amd64 ~ppc ~x86"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.0
	>=x11-libs/gtk+-2.4.11
	>=sys-libs/zlib-1.1.3
	=dev-scheme/guile-1.6*
	>=media-libs/libart_lgpl-2.3.8
	>=gnome-base/libgnomecanvas-2.0
	>=media-libs/libogg-1.0
	>=media-libs/libvorbis-1.0
	mad? ( media-sound/madplay )"
DEPEND="dev-util/pkgconfig
	dev-lang/perl
	media-libs/ladspa-cmt
	media-libs/ladspa-sdk
	${RDEPEND}"

src_compile() {
	# avoid suid related security issues.
	append-ldflags $(bindnow-flags)

	#for some weird reasons there is no doxer in this release
	econf $(use_enable debug) \
		$(use_enable static) \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	# dont install new mime files !
	rm -f "${D}/usr/share/mime/"*
	dodoc AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	fdo-mime_mime_database_update
}
