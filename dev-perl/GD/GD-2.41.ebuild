# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD/GD-2.41.ebuild,v 1.1 2008/09/10 17:12:12 tove Exp $

MODULE_AUTHOR=LDS
inherit eutils perl-module

DESCRIPTION="interface to Thomas Boutell's gd library"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="animgif gif jpeg png truetype xpm"

DEPEND=">=media-libs/gd-2.0.33
	png? ( media-libs/libpng sys-libs/zlib )
	jpeg? ( media-libs/jpeg )
	truetype? ( =media-libs/freetype-2* )
	xpm? ( x11-libs/libXpm )
	gif? ( media-libs/giflib )
	dev-lang/perl"

	SRC_TEST=do

pkg_setup() {
	local i_can_has_die=0

	if use jpeg && ! built_with_use media-libs/gd jpeg; then
		echo
		eerror "If you want to compile dev-perl/GD with USE=jpeg, you must first"
		eerror "compile media-libs/gd with USE=jpeg"
		i_can_has_die=1
	fi

	if use truetype && ! built_with_use media-libs/gd truetype; then
		echo
		eerror "If you want to compile dev-perl/GD with USE=truetype, you must first"
		eerror "compile media-libs/gd with USE=truetype"
		i_can_has_die=1
	fi

	if use png && ! built_with_use media-libs/gd png; then
		echo
		eerror "If you want to compile dev-perl/GD with USE=png, you must first"
		eerror "compile media-libs/gd with USE=png"
		i_can_has_die=1
	fi

	if use xpm && ! built_with_use media-libs/gd xpm; then
		echo
		eerror "If you want to compile dev-perl/GD with USE=xpm, you must first"
		eerror "compile media-libs/gd with USE=xpm"
		i_can_has_die=1
	fi

	[[ ${i_can_has_die} -ne 0 ]] && die "Please fix the errors above before continuing"
}

src_compile() {
	myconf=""
	use gif && use animgif && myconf="${myconf},ANIMGIF"
	use jpeg && myconf="${myconf},JPEG"
	use truetype && myconf="${myconf},FREETYPE"
	use png && myconf="${myconf},PNG"
	use xpm && myconf="${myconf},XPM"
	use gif && myconf="${myconf},GIF"
	myconf="-options \"${myconf:1}\""
	perl-module_src_compile
}

mydoc="GD.html"
