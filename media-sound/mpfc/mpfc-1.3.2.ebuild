# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/mpfc/mpfc-1.3.2.ebuild,v 1.3 2004/10/17 09:55:31 dholm Exp $

IUSE="alsa oss esd mad oggvorbis gpm"

inherit eutils

DESCRIPTION="Music Player For Console"
HOMEPAGE="http://mpfc.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86 ~ppc"

RDEPEND="alsa? ( >=media-libs/alsa-lib-0.9.0 )
	esd? ( >=media-sound/esound-0.2.22 )
	mad? ( media-libs/libmad )
	oggvorbis? ( media-libs/libvorbis )
	gpm? ( >=sys-libs/gpm-1.19.3 )"

DEPEND="${RDEPEND}
	sys-apps/findutils
	sys-apps/grep
	sys-apps/sed"

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
	local myconf="
		$(use_enable alsa) \
		$(use_enable oss) \
		$(use_enable esd) \
		$(use_enable mad mp3) \
		$(use_enable oggvorbis ogg) \
		$(use_enable gpm) \
		--sysconfdir=/etc"
	econf ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	insinto /etc
	doins mpfcrc
}
