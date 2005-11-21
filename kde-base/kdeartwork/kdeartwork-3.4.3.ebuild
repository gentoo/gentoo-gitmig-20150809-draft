# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeartwork/kdeartwork-3.4.3.ebuild,v 1.2 2005/11/21 17:54:38 gustavoz Exp $

inherit kde-dist eutils

DESCRIPTION="KDE artwork package"

KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc sparc ~x86"
IUSE="opengl xscreensaver"

DEPEND="~kde-base/kdebase-${PV}
	media-libs/libart_lgpl
	opengl? ( virtual/opengl )
	xscreensaver? ( x11-misc/xscreensaver )"

src_unpack() {
	kde_src_unpack

	# Configure patch. Applied for 3.5.
	epatch ${FILESDIR}/kdeartwork-3.4.3-configure.patch

	# Fix Makefile. Applied for 3.4.4.
	epatch ${FILESDIR}/kdeartwork-3.4.3-kfiresaver.patch

	# For the configure and Makefile patch.
	make -f admin/Makefile.common || die
}

src_compile() {
	local myconf="--with-dpms --with-libart
	              $(use_with opengl gl) $(use_with xscreensaver)"

	kde_src_compile
}
