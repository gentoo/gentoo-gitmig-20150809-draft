# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsaplayer/alsaplayer-0.99.71.20020607.ebuild,v 1.8 2003/09/07 00:06:04 msterret Exp $

IUSE="nas nls esd opengl doc oss gtk oggvorbis alsa"

S=${WORKDIR}/${PN}
DESCRIPTION="Media player primarily utilising ALSA"
SRC_URI="http://www.alsaplayer.org/${P}.tar.bz2"
HOMEPAGE="http://www.alsaplayer.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="alsa? ( >=media-libs/alsa-lib-0.5.10 )
	doc? ( app-doc/doxygen )
	esd? ( media-sound/esound )
	gtk? ( x11-libs/gtk+ )
	nas? ( media-libs/nas )
	opengl? ( virtual/opengl )
	oggvorbis? ( media-libs/libvorbis )
	>=media-libs/libmikmod-3.1.10
	>=dev-libs/glib-1.2.10"

RDEPEND="nls? ( sys-devel/gettext )"

src_compile() {

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

	export CPPFLAGS="${CPPFLAGS} -I/usr/X11R6/include"

	./bootstrap

	econf \
		--disable-sgi \
		--disable-sparc \
		${myconf} || die

	emake || die
}

src_install() {

	einstall \
		docdir=${D}/usr/share/doc/${P} \
		|| die

	dodoc AUTHORS COPYING ChangeLog README TODO
	dodoc docs/sockmon.txt docs/wishlist.txt
}
