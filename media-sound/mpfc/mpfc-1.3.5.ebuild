# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpfc/mpfc-1.3.5.ebuild,v 1.4 2005/08/07 13:37:28 hansmi Exp $

inherit eutils

DESCRIPTION="Music Player For Console"
HOMEPAGE="http://mpfc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="alsa esd gpm mad ogg oss"

RDEPEND="alsa? ( >=media-libs/alsa-lib-0.9.0 )
	esd? ( >=media-sound/esound-0.2.22 )
	gpm? ( >=sys-libs/gpm-1.19.3 )
	mad? ( media-libs/libmad )
	ogg? ( media-libs/libogg
		media-libs/libvorbis )"

src_unpack() {
	unpack ${A}

	# $(get_libdir) fixes
	cd ${S}
	find . -name 'Makefile.in' |
		xargs grep ^libdir |
		cut -f1 -d: |
		xargs sed -i "s:^\(libdir.*\)/lib/\(.*\)$:\1/$(get_libdir)/\2:" || die
}

src_compile() {
	econf \
		$(use_enable alsa) \
		$(use_enable esd) \
		$(use_enable gpm) \
		$(use_enable mad mp3) \
		$(use_enable ogg) \
		$(use_enable oss) \
		--sysconfdir=/etc \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	insinto /etc
	doins mpfcrc
}
