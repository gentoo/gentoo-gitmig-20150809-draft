# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/drip/drip-0.9.0_rc1.ebuild,v 1.5 2004/03/30 21:36:03 mr_bones_ Exp $

inherit eutils libtool

MY_P="${P/_}"
MY_P="${MY_P/rc1/-RC1}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Drip - A DVD to DIVX convertor frontend"
SRC_URI="http://drip.sourceforge.net/files/${MY_P}.tar.gz"
HOMEPAGE="http://drip.sourceforge.net/"

RDEPEND="gnome-base/gnome-libs
	>=media-video/avifile-0.7.22
	>=media-libs/a52dec-0.7.3
	>=media-libs/divx4linux-20020418
	>=media-libs/libdvdcss-1.2.2
	>=media-libs/libdvdread-0.9.3
	>=media-libs/libmpeg2-0.3.1
	media-gfx/imagemagick
	media-libs/gdk-pixbuf
	dev-libs/libxml2
	sys-apps/eject
	>=sys-devel/gcc-3"
# As of 0.9.0-RC1 gcc3 is required

DEPEND="${RDEPEND}
	dev-lang/nasm
	>=sys-devel/automake-1.5-r1"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 -ppc"
IUSE="nls"

src_unpack() {

	unpack ${A}

	# Fix the problem that if the /dev/dvd symlink is not absolute,
	# drip fails to start.  We do this by tring to figure what the
	# absolute path to the block device of a dvd drive is with help
	# from the dripgetdvd.sh script.
	# <azarah@gentoo.org>
	cd ${S} ; epatch ${FILESDIR}/${PN}-0.8.1-fix-dvd-symlink.patch

	# patch for changing types in >libmpeg-0.3.1
	if grep -q mpeg2_picture ${ROOT}/usr/include/mpeg2dec/mpeg2.h; then
		epatch ${FILESDIR}/libmpeg2.patch
	fi

	# Remove stale script ... "automake --add-missing" will add it again
	einfo "Rerunnig autoconf/automake..."
	cd ${S} ; rm -f ${S}/missing
	export WANT_AUTOMAKE_1_5=1
	aclocal -I macros
	automake --add-missing
	autoconf
}

src_compile() {

	elibtoolize

	local myconf=

	use nls || myconf="${myconf} --disable-nls"

	# Do not use custom CFLAGS !!!
	unset CFLAGS CXXFLAGS

	econf ${myconf} || die

	make || die
}

src_install() {

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		localstatedir=${D}/var/lib \
		sysconfdir=${D}/etc \
		drip_helpdir=${D}/usr/share/gnome/help/drip/C \
		drip_pixmapdir=${D}/usr/share/pixmaps \
		pixdir=${D}/usr/share/pixmaps/drip \
		install || die

	# Custom script for drip to get the *real* dvd device
	# It is a bit rough around the edges, but hopefully will do the trick.
	dobin ${FILESDIR}/dripgetdvd.sh

	insinto /usr/share/pixmaps
	newins ${S}/pixmaps/drip_logo.jpg drip.jpg
	insinto /usr/share/gnome/apps/Multimedia
	doins ${FILESDIR}/drip.desktop

	dodoc AUTHORS BUG-REPORT.TXT COPYING ChangeLog NEWS README TODO
}

