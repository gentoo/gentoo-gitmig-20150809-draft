# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsamixergui/alsamixergui-0.9.0.1.2-r4.ebuild,v 1.16 2009/06/01 15:01:47 ssuominen Exp $

EAPI=2
inherit autotools eutils

NATIVE_VER=0.9.0rc1-2

DESCRIPTION="AlsaMixerGui - a FLTK based amixer Frontend"
HOMEPAGE="http://www.iua.upf.es/~mdeboer/projects/alsamixergui/"
SRC_URI="ftp://www.iua.upf.es/pub/mdeboer/projects/alsamixergui/${PN}-${NATIVE_VER}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE=""

RDEPEND="media-libs/alsa-lib
	media-sound/alsa-utils
	x11-libs/fltk:1.1"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-${NATIVE_VER}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gcc34.patch \
		"${FILESDIR}"/segfault-on-exit.patch \
		"${FILESDIR}"/${P}-fltk-1.1.patch
	eautoreconf
}

src_configure() {
	export LDFLAGS="-L/usr/$(get_libdir)/fltk-1.1 ${LDFLAGS}"
	export CPPFLAGS="-I/usr/include/fltk-1.1 ${CPPFLAGS}"

	econf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS ChangeLog
	newicon src/images/alsalogo.xpm ${PN}.xpm
	make_desktop_entry alsamixergui "Alsa Mixer GUI" ${PN}
}
