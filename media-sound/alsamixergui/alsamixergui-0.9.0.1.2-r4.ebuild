# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsamixergui/alsamixergui-0.9.0.1.2-r4.ebuild,v 1.19 2011/03/22 10:01:35 jlec Exp $

EAPI=2

inherit autotools eutils flag-o-matic

MY_P=${PN}-0.9.0rc1-2

DESCRIPTION="FLTK based amixer Frontend"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="
	media-libs/alsa-lib
	media-sound/alsa-utils
	x11-libs/fltk:1"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc34.patch \
		"${FILESDIR}"/segfault-on-exit.patch \
		"${FILESDIR}"/${P}-fltk-1.1.patch
	eautoreconf
	append-ldflags "-L$(dirname $(fltk-config --libs))"
	append-flags "-I/usr/include/fltk-1"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS ChangeLog
	newicon src/images/alsalogo.xpm ${PN}.xpm
	make_desktop_entry alsamixergui "Alsa Mixer GUI" ${PN}
}
