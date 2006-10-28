# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/pekwm/pekwm-0.1.5.ebuild,v 1.2 2006/10/28 22:15:59 omp Exp $

inherit eutils

DESCRIPTION="A small window mananger based on aewm++"
HOMEPAGE="http://www.pekwm.org/"
SRC_URI="http://pekwm.org/files/${PF}.tar.bz2
	mirror://gentoo/${PN}-themes.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="debug perl truetype xinerama"

DEPEND="media-libs/imlib2
	x11-libs/libXpm
	x11-libs/libXrandr
	x11-libs/libXrender
	perl? ( dev-libs/libpcre )
	truetype? ( virtual/xft )
	xinerama? ( x11-libs/libXinerama )"
RDEPEND="${DEPEND}"

pkg_setup() {
	if ! built_with_use media-libs/imlib2 X ; then
		eerror "media-libs/imlib2 must be built with X support."
		die "missing X USE flag for media-libs/imlib2"
	fi
}

src_compile() {
	econf \
		$(use_enable truetype xft) \
		$(use_enable perl pcre) \
		$(use_enable xinerama) \
		$(use_enable debug) \
		--enable-menus \
		--enable-harbour \
		--enable-shape \
		--enable-xrandr \
		--enable-imlib2 || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog

	mv "${WORKDIR}/themes/"* "${D}/usr/share/${PN}/themes/"
}
