# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-tslib/xf86-input-tslib-0.0.6-r1.ebuild,v 1.9 2010/08/02 17:56:21 armin76 Exp $

# Based on xf86-input-synaptics ebuild

inherit toolchain-funcs eutils linux-info x-modular

PATCHLEVEL=3
DEBSOURCES="${PN}_${PV}-${PATCHLEVEL}.tar.gz"

DESCRIPTION="xorg input driver for use of tslib based touchscreen devices"
HOMEPAGE="http://www.pengutronix.de/software/xf86-input-tslib/index_en.html"
SRC_URI="ftp://cdn.debian.net/debian/pool/main/x/${PN}/${DEBSOURCES}"

LICENSE="GPL-2"
KEYWORDS="alpha amd64 arm hppa ia64 ~m68k ~mips ppc ppc64 sh sparc x86"
IUSE=""

RDEPEND="x11-base/xorg-server
	x11-libs/tslib"
DEPEND="${RDEPEND}
	x11-proto/inputproto"

S=${WORKDIR}/${PN}-trunk

# Remove stupid evdev checks.
# Never die simply cuz kernel sources do not exist.

src_install() {
	DOCS="COPYING ChangeLog"
	x-modular_src_install
	insinto /usr/share/hal/fdi/policy/20thirdparty/
	doins "${S}/debian/10-x11-input-tslib.fdi"
}
