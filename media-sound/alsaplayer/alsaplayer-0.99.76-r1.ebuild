# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsaplayer/alsaplayer-0.99.76-r1.ebuild,v 1.3 2005/03/13 14:42:29 luckyduck Exp $

inherit eutils

IUSE="nas nls esd opengl doc oss gtk ogg oggvorbis alsa jack mikmod flac xosd"

DESCRIPTION="Media player primarily utilising ALSA"
HOMEPAGE="http://www.alsaplayer.org/"
SRC_URI="http://www.alsaplayer.org/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86 ~mips"

RDEPEND=">=dev-libs/glib-1.2.10
	esd? ( media-sound/esound )
	gtk? ( =x11-libs/gtk+-1* )
	nas? ( media-libs/nas )
	alsa? ( media-libs/alsa-lib )
	jack? ( >=media-sound/jack-audio-connection-kit-0.80.0 )
	flac? ( media-libs/flac )
	mikmod? ( >=media-libs/libmikmod-3.1.10 )
	opengl? ( virtual/opengl )
	oggvorbis? ( media-libs/libvorbis )
	ogg? ( media-libs/libogg )
	xosd? ( x11-libs/xosd )"

DEPEND="${RDEPEND}
	sys-apps/sed
	doc? ( app-doc/doxygen )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	if use ppc; then
		epatch ${FILESDIR}/alsaplayer-endian.patch
	fi
}

src_compile() {
	export CPPFLAGS="${CPPFLAGS} -I/usr/X11R6/include"

	use xosd ||
		export ac_cv_lib_xosd_xosd_create="no"

	use doc ||
		export ac_cv_prog_HAVE_DOXYGEN="false"

	if use ogg && use flac; then
		myconf="${myconf} --enable-oggflac"
	fi

	econf \
		$(use_enable oss) \
		$(use_enable nas) \
		$(use_enable opengl) \
		$(use_enable nls) \
		$(use_enable sparc) \
		$(use_enable oggvorbis) \
		$(use_enable esd) \
		$(use_enable gtk) \
		$(use_enable jack) \
		$(use_enable mikmod) \
		$(use_enable flac) \
		${myconf} \
		--disable-sgi --disable-dependency-tracking || die "./configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} docdir=${D}/usr/share/doc/${PF} install \
		|| die "make install failed"

	dodoc AUTHORS COPYING ChangeLog README TODO
	dodoc docs/wishlist.txt
}
