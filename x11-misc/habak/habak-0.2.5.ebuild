# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/habak/habak-0.2.5.ebuild,v 1.18 2008/11/13 23:28:53 flameeyes Exp $

inherit eutils

DESCRIPTION="A simple but powerful tool to set desktop wallpaper"
HOMEPAGE="http://lubuska.zapto.org/~hoppke/"
SRC_URI="http://lubuska.zapto.org/~hoppke/yellow_brown/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="media-libs/imlib2
	x11-libs/libX11"
DEPEND="${RDEPEND}
	x11-proto/xproto"

pkg_setup() {
	# fix for bug #185144
	if ! built_with_use media-libs/imlib2 X; then
		eerror "habak needs imlib2 built with X USE flag"
		eerror "Please recompile media-libs/imlib2 with USE=X"
		die "habak needs media-libs/imlib2 built with USE=X"
	fi
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	dobin habak
	dodoc ChangeLog README TODO COPYING "${FILESDIR}"/README.en
}
