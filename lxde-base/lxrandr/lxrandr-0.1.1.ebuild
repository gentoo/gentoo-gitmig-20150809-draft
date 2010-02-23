# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/lxde-base/lxrandr/lxrandr-0.1.1.ebuild,v 1.10 2010/02/23 18:40:52 armin76 Exp $

EAPI="1"

inherit autotools eutils

DESCRIPTION="LXDE GUI interface to RandR extention"
HOMEPAGE="http://lxde.sf.net/"
SRC_URI="mirror://sourceforge/lxde/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="amd64 arm ppc x86"
SLOT="0"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	x11-libs/libXrandr
	x11-apps/xrandr"
DEPEND="${RDEPEND}
	x11-proto/randrproto
	dev-util/pkgconfig
	sys-devel/gettext
	>=dev-util/intltool-0.40.0"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-intltool.patch

	# Rerun autotools
	einfo "Regenerating autotools files..."
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed!"
	dodoc AUTHORS || die "dodoc failed"
}
