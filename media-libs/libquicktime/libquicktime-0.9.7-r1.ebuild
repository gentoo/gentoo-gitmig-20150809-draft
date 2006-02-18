# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libquicktime/libquicktime-0.9.7-r1.ebuild,v 1.8 2006/02/18 22:52:37 agriffis Exp $

inherit libtool eutils autotools

DESCRIPTION="A library based on quicktime4linux with extensions"
HOMEPAGE="http://libquicktime.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="gtk jpeg mmx vorbis png dv ieee1394 X"

DEPEND=">=sys-apps/sed-4.0.5
	dv? ( media-libs/libdv )
	gtk? ( >=x11-libs/gtk+-2.4.0 )
	png? ( media-libs/libpng )
	jpeg? ( media-libs/jpeg )
	vorbis? ( media-libs/libvorbis )
	ieee1394? (
		sys-libs/libavc1394
		sys-libs/libraw1394
	)
	X? ( || ( ( x11-libs/libXaw
				x11-libs/libXv
				x11-proto/xextproto
			)
			virtual/x11
		)
	)
	!virtual/quicktime"
PROVIDE="virtual/quicktime"

pkg_setup() {
	if has_version x11-base/xorg-x11 && ! built_with_use x11-base/xorg-x11 opengl; then
		die "You need xv support to compile ${PN}."
	fi
}

src_unpack() {
	unpack ${A}

	cd ${S}
	sed -i "s:\(have_libavcodec=\)true:\1false:g" configure.ac
	epatch "${FILESDIR}/${P}-dv.patch"

	eautoconf
	elibtoolize
}

src_compile() {
	econf --enable-shared \
		--enable-static \
		$(use_enable mmx) \
		$(use_enable ieee1394 firewire) \
		$(use_with dv libdv) \
		$(use_with X x) \
		--without-cpuflags

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	# Compatibility with software that uses quicktime prefix, but
	# don't do that when building for Darwin/MacOS
	[[ ${CHOST} != *-darwin* ]] && \
		dosym /usr/include/lqt /usr/include/quicktime
}

pkg_preinst() {
	if [[ -d /usr/include/quicktime && ! -L /usr/include/quicktime ]]; then
		einfo "For compatibility with other quicktime libraries, ${PN} was"
		einfo "going to create a /usr/lib/quicktime symlink, but for some,"
		einfo "on your system, that is a directory."
		einfo "Please check that is empty, and remove it, or submit a bug"
		einfo "telling us which package owns the directory."
		die "/usr/include/quicktime is a directory."
	fi
}

