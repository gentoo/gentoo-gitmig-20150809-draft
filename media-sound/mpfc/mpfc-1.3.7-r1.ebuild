# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpfc/mpfc-1.3.7-r1.ebuild,v 1.2 2008/01/13 15:30:32 aballier Exp $

inherit eutils multilib

DESCRIPTION="Music Player For Console"
HOMEPAGE="http://mpfc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="alsa gpm mad vorbis oss wav cdaudio nls"
RDEPEND="alsa? ( >=media-libs/alsa-lib-0.9.0 )
	gpm? ( >=sys-libs/gpm-1.19.3 )
	mad? ( media-libs/libmad )
	vorbis? ( media-libs/libvorbis )"

src_unpack() {
	unpack ${A}

	# $(get_libdir) fixes
	cd "${S}"
	find . -name 'Makefile.in' |
		xargs grep ^libdir |
		cut -f1 -d: |
		xargs sed -i "s:^\(libdir.*\)/lib/\(.*\)$:\1/$(get_libdir)/\2:" || die
	epatch "${FILESDIR}/${PN}-gcc4.patch"
	epatch "${FILESDIR}/${PN}-mathlib.patch"
}

src_compile() {
	econf \
		$(use_enable alsa) \
		$(use_enable gpm) \
		$(use_enable mad mp3) \
		$(use_enable vorbis ogg) \
		$(use_enable oss) \
		$(use_enable wav) \
		$(use_enable cdaudio audiocd) \
		$(use_enable nls) \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	insinto /etc; doins mpfcrc

	dodoc AUTHORS ChangeLog NEWS README
}
