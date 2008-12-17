# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-lastfm/gmpc-lastfm-0.16.1.ebuild,v 1.2 2008/12/17 21:40:37 maekke Exp $

inherit autotools eutils multilib

MY_PN="gmpc-last.fm"
MY_P=${MY_PN}-${PV}

DESCRIPTION="This plugin fetches artist art from last.fm"
HOMEPAGE="http://gmpcwiki.sarine.nl/index.php/Last.fm"
SRC_URI="http://download.sarine.nl/Programs/gmpc/${PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86"
IUSE=""

RDEPEND=">=media-sound/gmpc-${PV}
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if ! built_with_use =x11-libs/gtk+-2* jpeg ; then
		echo
		eerror "x11-libs/gtk+-2 needs to be built with \"jpeg\" USE flag"
		die "x11-libs/gtk+-2 needs to be built with \"jpeg\" USE flag"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i "/^libdir/s:/lib/:/$(get_libdir)/:" src/Makefile.am
	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die
}
