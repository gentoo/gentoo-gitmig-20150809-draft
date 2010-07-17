# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/xlog/xlog-2.0.3.ebuild,v 1.3 2010/07/17 12:43:00 fauli Exp $

EAPI=2

inherit autotools eutils fdo-mime

DESCRIPTION="An amateur radio logging program"
HOMEPAGE="http://www.nongnu.org/xlog"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="media-libs/hamlib
	=dev-libs/glib-2*
	>=x11-libs/gtk+-2.12"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig"

src_prepare() {
	# Let portage handle updating mime/desktop databases,
	epatch "${FILESDIR}/${PN}-1.9-desktop-update.patch"
	# and patch wrong ADIF export
	epatch "${FILESDIR}/${PN}-2.0.1-adif.patch" \
	    "${FILESDIR}/${PN}-2.0.2-qsl.patch"
	eautoreconf
}

src_configure() {
	# mime-update causes file collisions if enabled
	econf --disable-mime-update --disable-desktop-update \
		--docdir=/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS data/doc/THANKS NEWS README || die "dodoc failed"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}
