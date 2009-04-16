# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/xf86-input-tslib/xf86-input-tslib-0.0.5-r1.ebuild,v 1.10 2009/04/16 23:43:26 solar Exp $

# Based on xf86-input-synaptics ebuild

inherit toolchain-funcs eutils linux-info x-modular

PATCHLEVEL=6
PATCHFILE="${PN}_${PV}-${PATCHLEVEL}.diff"

DESCRIPTION="xorg input driver for use of tslib based touchscreen devices"
HOMEPAGE="http://www.pengutronix.de/software/${PN}/index_en.html"
SRC_URI="http://www.pengutronix.de/software/${PN}/download/${P}.tar.bz2
	ftp://cdn.debian.net/debian/pool/main/x/${PN}/${PATCHFILE}.gz"
KEYWORDS="~alpha amd64 ~arm hppa ia64 ~m68k ~mips ppc ppc64 sh sparc x86"
LICENSE="GPL-2"
IUSE=""
RDEPEND="x11-base/xorg-server x11-libs/tslib"
DEPEND="x11-proto/inputproto"

# Remove stupid evdev checks.
# Never die simply cuz kernel sources do not exist.

src_unpack() {
	x-modular_unpack_source
	cd "${WORKDIR}"
	epatch "${WORKDIR}/${PATCHFILE}"
	EPATCH_OPTS="-p0" EPATCH_SOURCE="${S}/debian/patches" EPATCH_SUFFIX="diff" EPATCH_FORCE="yes" epatch
}

src_install() {
	DOCS="COPYING ChangeLog"
	x-modular_src_install
	insinto /usr/share/hal/fdi/policy/20thirdparty/
	doins "${S}/debian/10-x11-input-tslib.fdi"
}
