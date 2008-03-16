# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gmpc-lastfm/gmpc-lastfm-0.15.5.0.ebuild,v 1.4 2008/03/16 17:13:41 maekke Exp $

inherit eutils

MY_PN="gmpc-last.fm"
MY_P=${MY_PN}-${PV}

DESCRIPTION="This plugin fetches artist art from last.fm"
HOMEPAGE="http://sarine.nl/gmpc-plugins-lastfm"
SRC_URI="http://download.sarine.nl/gmpc-0.15.5/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
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

src_install () {
	emake DESTDIR="${D}" install || die
}
