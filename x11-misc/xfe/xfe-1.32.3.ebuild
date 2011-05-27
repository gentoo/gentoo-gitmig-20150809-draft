# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xfe/xfe-1.32.3.ebuild,v 1.1 2011/05/27 07:21:52 xarthisius Exp $

EAPI=4

inherit base

DESCRIPTION="MS-Explorer-like minimalist file manager for X"
HOMEPAGE="http://roland65.free.fr/xfe"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug nls startup-notification"

RDEPEND="x11-libs/libX11
	media-libs/libpng
	=x11-libs/fox-1.6*[truetype,png]
	startup-notification? ( x11-libs/startup-notification )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS BUGS ChangeLog NEWS README TODO )
PATCHES=( "${FILESDIR}"/${PN}-1.32.2-missing_Xlib_h.patch )

src_prepare() {
	base_src_prepare
	cat >po/POTFILES.skip <<-EOF
	src/icons.cpp
	xfe.desktop.in.in
	xfi.desktop.in.in
	xfp.desktop.in.in
	xfv.desktop.in.in
	xfw.desktop.in.in
	EOF
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		$(use_enable startup-notification sn) \
		$(use_enable debug)
}
