# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/ogle/ogle-0.9.2-r2.ebuild,v 1.7 2011/02/26 19:30:17 signals Exp $

inherit eutils libtool

DESCRIPTION="Full featured DVD player that supports DVD menus."
HOMEPAGE="http://www.dtek.chalmers.se/groups/dvd/"
SRC_URI="http://www.dtek.chalmers.se/groups/dvd/dist/${P}.tar.gz"

SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
LICENSE="GPL-2"
IUSE="alsa altivec css mmx oss xv"

RDEPEND="css? ( >=media-libs/libdvdcss-1.2.2 )
	virtual/jpeg
	>=media-libs/libdvdread-0.9.4
	media-libs/libmad
	x11-libs/libXinerama
	x11-libs/libXxf86vm
	x11-libs/libICE
	x11-libs/libSM
	xv? ( x11-libs/libXv )
	>=dev-libs/libxml2-2.4.19
	>=media-libs/a52dec-0.7.3
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}
	x11-proto/xextproto
	x11-proto/xf86vidmodeproto
	x11-proto/xineramaproto
	xv? ( x11-proto/videoproto )"

src_unpack() {
	unpack ${A}

	cd "${S}"

	# Removing vunlerable scripts, bug 245921
	epatch "${FILESDIR}"/ogle-vuln-scripts-makefile.patch
	rm scripts/*debug || die "rm failed"

	epatch \
		"${FILESDIR}"/ogle-configure-alsa-fix.patch \
		"${FILESDIR}"/ogle-gcc34-fix.patch \
		"${FILESDIR}"/ogle-gcc4-fix.patch

	elibtoolize
}

src_compile() {
	# STOP!  If you make any changes, make sure to unmerge all copies
	# of ogle and ogle-gui from your system and merge ogle-gui using your
	# new version of ogle... Changes in this package can break ogle-gui
	# very very easily -- blocke

	# configure needs access to the updated CFLAGS
	CFLAGS="${CFLAGS} -I/usr/include/libxml2/libxml -I/usr/include/libxml2"

	econf \
		$(use_enable mmx) \
		$(use_enable altivec) \
		$(use_enable oss) \
		$(use_enable alsa) \
		$(use_enable xv) \
		${myconf} || die "./configure failed"
	emake CFLAGS="${CFLAGS}" || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README

	cd "${D}"usr/bin/
	mv ./ifo_dump ./ifo_dump_ogle
}
