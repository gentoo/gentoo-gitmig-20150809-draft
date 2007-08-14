# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xnee/xnee-3.01.ebuild,v 1.2 2007/08/14 15:44:42 drac Exp $

inherit eutils

MY_P=${P/x/X}

DESCRIPTION="Program suite to record, replay and distribute user actions."
HOMEPAGE="http://www.sandklef.com/xnee"
SRC_URI="mirror://gnu/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86"
IUSE="gnome gtk xosd"

RDEPEND="x11-libs/libX11
	x11-libs/libXtst
	gtk? ( >=x11-libs/gtk+-2 )
	gnome? ( gnome-base/gconf
		gnome-base/gnome-panel )"
DEPEND="sys-apps/sed
	dev-util/pkgconfig
	gtk? ( sys-devel/gettext media-gfx/imagemagick )"

S="${WORKDIR}"/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-destdir.patch
}

src_compile() {
	local myconf

	if use xosd; then
		myconf="--enable-xosd --enable-verbose --enable-buffer_verbose"
	else
		myconf="--disable-xosd --disable-verbose --disable-buffer_verbose"
	fi

	econf --enable-cli --enable-lib \
		$(use_enable gnome gnome-applet) \
		$(use_enable gtk gui) \
		${myconf}

	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS BUGS ChangeLog FAQ NEWS README TODO

	dolib libxnee/src/libxnee*

	if use gtk; then
		doicon pixmap/xnee.png
		make_desktop_entry gnee Gnee xnee.png "Utility;GTK"
	fi
}
