# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/tango-icon-theme-extras/tango-icon-theme-extras-0.1.0-r1.ebuild,v 1.14 2010/07/08 02:21:20 ssuominen Exp $

EAPI=2
inherit autotools eutils gnome2-utils

DESCRIPTION="Tango icons for iPod Digital Audio Player (DAP) devices and the Dell Pocket DJ DAP."
HOMEPAGE="http://tango.freedesktop.org"
SRC_URI="http://tango.freedesktop.org/releases/${P}.tar.gz"

LICENSE="CCPL-Attribution-ShareAlike-2.5"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="png"

RESTRICT="binchecks strip"

RDEPEND=">=x11-themes/tango-icon-theme-0.8.90"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=gnome-base/librsvg-2.12.3
	|| ( media-gfx/imagemagick[png?] media-gfx/graphicsmagick[imagemagick,png?] )
	>=x11-misc/icon-naming-utils-0.8.90"

src_prepare() {
	epatch "${FILESDIR}"/${P}-graphicsmagick.patch
	eautoreconf
}

src_configure() {
	econf \
		$(use_enable png png-creation) \
		$(use_enable png icon-framing)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}

pkg_preinst() { gnome2_icon_savelist; }
pkg_postinst() { gnome2_icon_cache_update; }
pkg_postrm() { gnome2_icon_cache_update; }
