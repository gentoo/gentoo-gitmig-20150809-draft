# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsamixergui/alsamixergui-0.9.0.1.2-r4.ebuild,v 1.7 2004/12/06 13:13:55 josejx Exp $

IUSE=""

inherit eutils

NATIVE_VER=0.9.0rc1-2
S=${WORKDIR}/${PN}-${NATIVE_VER}

DESCRIPTION="AlsaMixerGui - a FLTK based amixer Frontend"
HOMEPAGE="http://www.iua.upf.es/~mdeboer/projects/alsamixergui/"
SRC_URI="ftp://www.iua.upf.es/pub/mdeboer/projects/alsamixergui/${PN}-${NATIVE_VER}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~ppc64 ~sparc x86"

DEPEND="virtual/alsa
	>=media-libs/alsa-lib-0.9.0_rc1
	>=media-sound/alsa-utils-0.9.0_rc1
	>=x11-libs/fltk-1.1.0_rc6"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gentoo.diff
	epatch ${FILESDIR}/${P}-gcc34.patch
	epatch ${FILESDIR}/segfault-on-exit.patch
}

src_compile() {
	export LDFLAGS="-L/usr/$(get_libdir)/fltk-1.1 ${LDFLAGS}"
	export CPPFLAGS="-I/usr/include/fltk-1.1 ${CPPFLAGS}"

	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README AUTHORS ChangeLog
}
