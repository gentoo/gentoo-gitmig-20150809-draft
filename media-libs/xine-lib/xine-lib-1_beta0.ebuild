# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2 
# $Header: /var/cvsroot/gentoo-x86/media-libs/xine-lib/xine-lib-1_beta0.ebuild,v 1.4 2003/03/07 23:25:49 agenkin Exp $ 

DESCRIPTION="Core libraries for Xine movie player."
HOMEPAGE="http://xine.sourceforge.net/"
LICENSE="GPL-2"

DEPEND="oggvorbis? ( media-libs/libvorbis )
	X? ( virtual/x11 )
	avi? ( >=media-libs/win32codecs-0.50 
	       media-libs/divx4linux )
	esd? ( media-sound/esound )
	dvd? ( >=media-libs/libdvdcss-0.0.3.3
	       >=media-libs/libdvdread-0.9.2 )
	arts? ( kde-base/kdelibs )
	alsa? ( media-libs/alsa-lib )
	aalib? ( media-libs/aalib )
	directfb? ( >=dev-libs/DirectFB-0.9.9
		    dev-util/pkgconfig )"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"

IUSE="arts esd avi nls dvd aalib X directfb oggvorbis alsa"

SLOT="0"
KEYWORDS="~x86"

S=${WORKDIR}/${PN}-${PV/_/-}
SRC_URI="mirror://sourceforge/xine/${PN}-${PV/_/-}.tar.gz"

# this build doesn't play nice with -maltivec (gcc 3.2 only option) on ppc
inherit flag-o-matic  || die "I lost my inheritance"
filter-flags "-maltivec -mabi=altivec"
replace-flags k6-3 i686
replace-flags k6-2 i686
replace-flags k6   i686

src_compile() {

	# Most of these are not working currently, but are here for completeness
	# don't use the --disable-XXXtest because that defaults to ON not OFF
	local myconf
	use X \
		|| myconf="${myconf} --disable-x11" # --disable-xv"
	use esd	\
		|| myconf="${myconf} --disable-esd" # --disable-esdtest"
	use nls	\
		|| myconf="${myconf} --disable-nls"
	use alsa \
		|| myconf="${myconf} --disable-alsa" # --disable-alsatest"
	use arts \
		|| myconf="${myconf} --disable-arts" # --disable-artstest"
	use aalib \
		|| myconf="${myconf} --disable-aalib" # --disable-aalibtest"
	use oggvorbis \
		|| myconf="${myconf} --disable-ogg --disable-vorbis"
			   #--disable-oggtest --disable-vorbistest"
	use avi	\
		&& myconf="${myconf} --with-w32-path=/usr/lib/win32" \
		|| myconf="${myconf} --disable-asf"

	einfo "myconf: ${myconf}"

	econf ${myconf} || die
	emake || die
}

src_install() {
	
	make DESTDIR=${D} install || die

	# Xine's makefiles install some file incorrectly. (Gentoo bug #8583).
	dodir /usr/share/xine/fonts
	mv ${D}/usr/share/*.xinefont.gz ${D}/usr/share/xine/fonts/
	dodir /usr/share/xine/skins
	mv ${D}/usr/share/xine_logo.mpv ${D}/usr/share/xine/skins/

	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
	cd ${S}/doc
	dodoc dataflow.dia README*

}

pkg_postinst() {

	einfo
	einfo "Please note, a new version of xine-lib has been installed,"
	einfo "for library consistency you need to unmerge old versions"
	einfo "of xine-lib before merging xine-ui."
	einfo

}
