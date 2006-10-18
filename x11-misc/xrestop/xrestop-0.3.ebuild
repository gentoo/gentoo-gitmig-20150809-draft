# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xrestop/xrestop-0.3.ebuild,v 1.13 2006/10/18 03:51:43 jer Exp $

IUSE=""

DESCRIPTION="'Top' like statistics of X11 client's server side resource usage"
SRC_URI="http://www.freedesktop.org/Software/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.freedesktop.org/wiki/Software_2fxrestop"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc sparc x86"

RDEPEND="|| ( (
		x11-libs/libXres
		x11-libs/libX11
		x11-libs/libXt )
	virtual/x11 )"
DEPEND="${RDEPEND}
	|| ( x11-proto/xproto virtual/x11 )"

src_install () {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README
}
