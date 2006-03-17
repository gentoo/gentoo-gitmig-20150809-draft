# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/idesk/idesk-0.7.5-r1.ebuild,v 1.6 2006/03/17 13:09:46 jer Exp $

DESCRIPTION="Utility to place icons on the root window"
HOMEPAGE="http://idesk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ~ppc64 sparc x86"
IUSE=""

DEPEND=">=media-libs/imlib2-1.1.2.20040912
	media-libs/freetype
	>=dev-util/pkgconfig-0.12.0
	dev-libs/libxml2
	=dev-libs/glib-2*
	gnome-extra/libgsf
	=x11-libs/pango-1*
	=x11-libs/gtk+-2*
	media-libs/libart_lgpl
	x11-libs/startup-notification"

src_unpack() {
	unpack "${A}"
	cd "${S}"
	sed -i -e 's,/usr/local/,/usr/,' examples/default.lnk
}

src_compile() {
	econf --enable-libsn || die "configuration failed"
	emake || die "compilation failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README AUTHORS NEWS TODO
}

pkg_postinst() {
	einfo "Please refer to ${HOMEPAGE} for info on configuring ${PN}"
}
