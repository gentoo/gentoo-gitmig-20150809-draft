# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/drip/drip-0.9.0.ebuild,v 1.2 2004/11/01 01:08:07 vapier Exp $

inherit eutils libtool flag-o-matic

DESCRIPTION="A DVD to DIVX convertor frontend"
HOMEPAGE="http://drip.sourceforge.net/"
SRC_URI="http://drip.sourceforge.net/files/${P}.tar.gz
	 mirror://debian/pool/main/d/drip/drip_0.8.3.2+0.9.0-rc3-5.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls"

RDEPEND="gnome-base/gnome-libs
	>=media-video/avifile-0.7.34
	>=media-libs/a52dec-0.7.3
	>=media-libs/divx4linux-20020418
	>=media-libs/libdvdcss-1.2.2
	>=media-libs/libdvdread-0.9.3
	>=media-libs/libmpeg2-0.4.0
	>=media-libs/xvid-0.9.2
	media-gfx/imagemagick
	media-libs/gdk-pixbuf
	dev-libs/libxml2
	sys-apps/eject
	>=sys-devel/gcc-3"
DEPEND="${RDEPEND}
	dev-lang/nasm
	>=sys-devel/automake-1.5-r1"

src_unpack() {
	unpack ${A}

	cd ${S}

	# Many thanks to the Debian devs.  Fixes libmpeg2-0.4.0 support.
	epatch ${WORKDIR}/drip_0.8.3.2+0.9.0-rc3-5.diff
	epatch ${S}/drip-0.8.3.2+0.9.0-rc3/debian/patches/magickfilter_ftbfs.diff
	epatch ${S}/drip-0.8.3.2+0.9.0-rc3/debian/patches/mpeg2_api.diff
	epatch ${S}/drip-0.8.3.2+0.9.0-rc3/debian/patches/noopt.diff

	# Fix the problem that if the /dev/dvd symlink is not absolute,
	# drip fails to start.  We do this by tring to figure what the
	# absolute path to the block device of a dvd drive is with help
	# from the dripgetdvd.sh script.
	# <azarah@gentoo.org>
	epatch ${FILESDIR}/${PN}-0.8.1-fix-dvd-symlink.patch

	# Honor user CFLAGS
	epatch ${FILESDIR}/${P}-cflags.patch

	# Remove stale script ... "automake --add-missing" will add it again
	einfo "Rerunnig autoconf/automake..."
	cd ${S} ; rm -f ${S}/missing
	export WANT_AUTOMAKE=1.5
	aclocal -I macros
	automake --add-missing
	autoconf
	elibtoolize
}

src_compile() {
	local myconf=

	use nls || myconf="${myconf} --disable-nls"

	use x86 && append-flags "-DARCH_X86"

	econf ${myconf} || die

	make || die
}

src_install() {
	einstall \
		drip_helpdir=${D}/usr/share/gnome/help/drip/C \
		drip_pixmapdir=${D}/usr/share/pixmaps \
		pixdir=${D}/usr/share/pixmaps/drip \
		|| die

	# Custom script for drip to get the *real* dvd device
	# It is a bit rough around the edges, but hopefully will do the trick.
	dobin ${FILESDIR}/dripgetdvd.sh

	insinto /usr/share/pixmaps
	newins ${S}/pixmaps/drip_logo.jpg drip.jpg
	insinto /usr/share/applications
	doins ${FILESDIR}/drip.desktop
	insinto /usr/share/applnk/Multimedia
	doins ${FILESDIR}/drip.desktop

	dodoc AUTHORS BUG-REPORT.TXT COPYING ChangeLog NEWS README TODO
}
