# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libquicktime/libquicktime-0.9.3.ebuild,v 1.1 2004/10/27 14:26:35 zypher Exp $

inherit libtool eutils

DESCRIPTION="A library based on quicktime4linux with extensions"
HOMEPAGE="http://libquicktime.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc"

IUSE="gtk jpeg mmx oggvorbis png"

DEPEND=">=sys-apps/sed-4.0.5
	media-libs/libdv
	gtk? ( =x11-libs/gtk+-1.2* )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	oggvorbis? ( media-libs/libvorbis )
	!virtual/quicktime"
PROVIDE="virtual/quicktime"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:\(have_libavcodec=\)true:\1false:g" configure.ac

	# Fix bug 10966 by replacing the x86-centric OPTIMIZE_CFLAGS with
	# our $CFLAGS
	if ! use x86; then
		mv configure.ac configure.ac.old
		awk -F= '$1=="OPTIMIZE_CFLAGS" { print $1"="cflags; next }
		         { print }' cflags="$CFLAGS" \
					 <configure.ac.old >configure.ac || die
	fi

#	use amd64 && epatch ${FILESDIR}/${P}-amd64.patch
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
		${myconf} \
		|| die
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
}
