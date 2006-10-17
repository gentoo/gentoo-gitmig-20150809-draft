# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libquicktime/libquicktime-0.9.10.ebuild,v 1.1 2006/10/17 06:42:08 aballier Exp $

inherit libtool eutils autotools

DESCRIPTION="A library based on quicktime4linux with extensions"
HOMEPAGE="http://libquicktime.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="mmx X"

DEPEND="media-libs/libdv
	>=x11-libs/gtk+-2.4.0
	media-libs/libpng
	media-libs/jpeg
	media-libs/libvorbis
	media-libs/libogg
	>=media-libs/x264-svn-20060810
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
	if has_version '=x11-base/xorg-x11-6*' && ! built_with_use x11-base/xorg-x11 xv; then
		die "You need xv support to compile ${PN}."
	fi
}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${P}-x264.patch"
}

src_compile() {
	econf --enable-shared \
		--enable-static \
		--enable-gpl \
		$(use_enable mmx) \
		$(use_with X x) \
		--without-cpuflags || die "econf failed"
		emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# Compatibility with software that uses quicktime prefix, but
	# don't do that when building for Darwin/MacOS
	[[ ${CHOST} != *-darwin* ]] && \
	dosym /usr/include/lqt /usr/include/quicktime
}

pkg_preinst() {
	if [[ -d /usr/include/quicktime && ! -L /usr/include/quicktime ]]; then
		einfo "For compatibility with other quicktime libraries, ${PN} was"
		einfo "going to create a /usr/include/quicktime symlink, but for some"
		einfo "reason that is a directory on your system."

		if $(has_version =media-libs/libquicktime-0.9.4); then
			einfo "It seems this directory belongs to libquicktime-0.9.4."
			einfo "We'll delete that directory now."
			rm -rvf /usr/include/quicktime
		else
			einfo "Please check that is empty, and remove it, or submit a bug"
			einfo "telling us which package owns the directory."
			die "/usr/include/quicktime is a directory."
		fi
	fi
}

