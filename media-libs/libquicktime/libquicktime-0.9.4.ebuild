# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libquicktime/libquicktime-0.9.4.ebuild,v 1.1 2005/03/12 18:44:38 luckyduck Exp $

inherit libtool eutils

DESCRIPTION="A library based on quicktime4linux with extensions"
HOMEPAGE="http://libquicktime.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~ppc64"

IUSE="gtk jpeg mmx oggvorbis png dv ieee1394"

DEPEND=">=sys-apps/sed-4.0.5
	dv? ( media-libs/libdv )
	gtk? ( =x11-libs/gtk+-1.2* )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	oggvorbis? ( media-libs/libvorbis )
	ieee1394? (
		sys-libs/libavc1394
		sys-libs/libraw1394
	)
	!virtual/quicktime"
PROVIDE="virtual/quicktime"

src_unpack() {
	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${P}-cflags.patch

	sed -i "s:\(have_libavcodec=\)true:\1false:g" configure.ac
}

src_compile() {
	ebegin "Regenerating configure script..."
	autoconf
	eend
	elibtoolize

	local myconf

	econf \
		`use_enable mmx` \
		`use_enable gtk` \
		`use_enable ieee1394 firewire` \
		${myconf} \
		|| die "./configure failed"
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}
