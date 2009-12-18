# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-laptop/radeontool/radeontool-1.6.0.ebuild,v 1.1 2009/12/18 00:26:41 robbat2 Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Manage the backlight, external video output and registers of ATI Radeon graphics cards"

HOMEPAGE="http://cgit.freedesktop.org/~airlied/radeontool/"
SRC_URI="http://people.freedesktop.org/~airlied/${PN}/${P}.tar.bz2"

LICENSE="ZLIB"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

RDEPEND="x11-libs/libpciaccess"
DEPEND="${RDEPEND}"

src_install() {
	emake install DESTDIR="${D}"
}
