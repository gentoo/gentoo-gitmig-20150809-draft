# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/tlf/tlf-0.9.31.2.ebuild,v 1.3 2011/02/13 19:19:43 armin76 Exp $

inherit flag-o-matic versionator multilib

MY_PV=$(replace_version_separator 3 '-')
MY_P=${PN}-${MY_PV}

DESCRIPTION="Console-mode amateur radio contest logger"
HOMEPAGE="http://home.iae.nl/users/reinc/TLF-0.2.html"
SRC_URI="http://sharon.esrac.ele.tue.nl/pub/linux/ham/tlf/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="sys-libs/ncurses
	media-libs/hamlib"
DEPEND="${RDEPEND}
	sys-apps/gawk"

S=${WORKDIR}/${PN}-$(get_version_component_range 1-3)

src_compile() {
	append-flags -L/usr/$(get_libdir)/hamlib
	econf --enable-hamlib
	emake || die "emake failed."
}

src_install() {
	einstall || die "einstall failed."
	rm -fR "${D}"/usr/share/${PN}/doc
	dodoc AUTHORS ChangeLog NEWS doc/README
}
