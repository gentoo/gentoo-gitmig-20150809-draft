# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsaplayer/alsaplayer-0.99.76.ebuild,v 1.4 2004/02/17 19:03:54 ciaranm Exp $

IUSE="nas nls esd opengl doc oss gtk oggvorbis alsa jack mikmod flac"

S=${WORKDIR}/${P}
DESCRIPTION="Media player primarily utilising ALSA"
HOMEPAGE="http://www.alsaplayer.org/"
SRC_URI="http://www.alsaplayer.org/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc -sparc ~alpha ~hppa ~mips ~arm ~amd64 ~ia64"

DEPEND=">=dev-libs/glib-1.2.10
	doc? ( app-doc/doxygen )
	esd? ( media-sound/esound )
	gtk? ( x11-libs/gtk+ )
	nas? ( media-libs/nas )
	alsa? ( media-libs/alsa-lib )
	jack? ( >=media-sound/jack-audio-connection-kit-0.80.0 )
	flac? ( media-libs/flac )
	mikmod? ( >=media-libs/libmikmod-3.1.10 )
	opengl? ( virtual/opengl )
	oggvorbis? ( media-libs/libvorbis )"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {
	export CPPFLAGS="${CPPFLAGS} -I/usr/X11R6/include"

	econf \
		`use_enable oss` \
		`use_enable nas` \
		`use_enable opengl` \
		`use_enable nls` \
		`use_enable sparc` \
		`use_enable oggvorbis` \
		`use_enable esd` \
		`use_enable gtk` \
		`use_enable jack` \
		`use_enable mikmod` \
		`use_enable flac` \
		--disable-sgi || die

	emake || die
}

src_install() {

	make DESTDIR=${D} docdir=${D}/usr/share/doc/${PF} install

	dodoc AUTHORS COPYING ChangeLog README TODO
	dodoc docs/wishlist.txt
}
