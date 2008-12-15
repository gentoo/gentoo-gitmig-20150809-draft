# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/svxlink/svxlink-080730.ebuild,v 1.2 2008/12/15 12:27:51 pva Exp $

EAPI=1

inherit kde-functions

DESCRIPTION="Multi Purpose Voice Services System, including Qtel for EchoLink"
HOMEPAGE="http://svxlink.sourceforge.net/"
SRC_URI="mirror://sourceforge/svxlink/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="dev-lang/tcl
	media-sound/gsm
	x11-libs/qt:3
	dev-libs/libsigc++:1.2
	>=media-libs/spandsp-0.0.6_pre2
	dev-libs/popt"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-fix-Makefile.diff"
	epatch "${FILESDIR}/${P}--as-needed.patch"
	epatch "${FILESDIR}/${P}-spandsp-0.0.6_pre2.patch"
}

src_compile() {
	set-kdedir
	emake -j1 || die "emake failed"
}

src_install() {
	emake \
		INSTALL_ROOT="${D}" \
		install || die "emake install failed"
}
