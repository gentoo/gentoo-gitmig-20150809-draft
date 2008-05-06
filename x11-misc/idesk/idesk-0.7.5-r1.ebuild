# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/idesk/idesk-0.7.5-r1.ebuild,v 1.9 2008/05/06 13:39:18 drac Exp $

inherit eutils

DESCRIPTION="Utility to place icons on the root window"
HOMEPAGE="http://idesk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-libs/imlib2-1.1.2.20040912
	media-libs/freetype
	dev-libs/libxml2
	=dev-libs/glib-2*
	gnome-extra/libgsf
	=x11-libs/pango-1*
	=x11-libs/gtk+-2*
	media-libs/libart_lgpl
	x11-libs/startup-notification"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	if ! built_with_use media-libs/imlib2 X; then
		eerror "You need to have media-libs/imlib2 compiled with USE=\"X\""
		die "You need to have media-libs/imlib2 compiled with USE=\"X\""
	fi
}

src_unpack() {
	unpack "${A}"
	sed -i -e 's,/usr/local/,/usr/,' "${S}"/examples/default.lnk
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
