# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsaplayer/alsaplayer-0.99.75-r1.ebuild,v 1.5 2004/03/26 21:29:28 eradicator Exp $

IUSE="nas nls esd opengl doc oss gtk oggvorbis alsa"

DESCRIPTION="Media player primarily utilising ALSA"
HOMEPAGE="http://www.alsaplayer.org/"
SRC_URI="http://www.alsaplayer.org/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc -sparc ~alpha ~amd64"

RDEPEND="alsa? ( >=media-libs/alsa-lib-0.9 )
	doc? ( app-doc/doxygen )
	esd? ( media-sound/esound )
	gtk? ( x11-libs/gtk+ )
	nas? ( media-libs/nas )
	opengl? ( virtual/opengl )
	oggvorbis? ( media-libs/libvorbis )
	>=media-libs/libmikmod-3.1.10
	>=dev-libs/glib-1.2.10"

DEPEND="${RDEPEND}
	sys-apps/sed
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i "/#if SND_LIB_MAJOR>0 || (SND_LIB_MAJOR==0 && SND_LIB_MINOR==5)/s/SND_LIB_MAJOR>0 ||//" configure
}

src_compile() {
	epatch ${FILESDIR}/gcc.patch

	local myconf

	use oggvorbis \
		&& myconf="--enable-oggvorbis" \
		|| myconf="--disable-oggvorbis --disable-oggtest --disable-vorbistest"

	use oss \
		&& myconf="${myconf} --enable-oss" \
		|| myconf="${myconf} --disable-oss"

	use esd \
		&& myconf="${myconf} --enable-esd" \
		|| myconf="${myconf} --disable-esd --disable-esdtest"

	use nas \
		&& myconf="${myconf} --enable-nas" \
		|| myconf="${myconf} --disable-nas"

	use opengl \
		&& myconf="${myconf} --enable-opengl" \
		|| myconf="${myconf} --disable-opengl"

	use gtk \
		&& myconf="${myconf} --enable-gtk" \
		|| myconf="${myconf} --disable-gtk --disable-gtktest --disable-glibtest"

	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"

	use sparc \
		&& myconf="${myconf} --enable-sparc" \
		|| myconf="${myconf} --disable-sparc"

	export CPPFLAGS="${CPPFLAGS} -I/usr/X11R6/include"

	econf \
		--disable-sgi \
		${myconf}

#	./configure --enable-gtk --libdir=/usr/lib/alsaplayer

	emake || die
}

src_install() {

	make DESTDIR=${D} docdir=${D}/usr/share/doc/${PF} install

#	einstall \
#		docdir=${D}/usr/share/doc/${P}

	dodoc AUTHORS COPYING ChangeLog README TODO DONATION*
	dodoc docs/sockmon.txt docs/wishlist.txt
}
