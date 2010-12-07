# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD/GD-2.45-r1.ebuild,v 1.1 2010/12/07 08:31:02 tove Exp $

EAPI=3

MODULE_AUTHOR=LDS
inherit perl-module

DESCRIPTION="interface to Thomas Boutell's gd library"

LICENSE="|| ( Artistic-2 GPL-1 GPL-2 GPL-3 )" # Artistic-2 or GPL1+
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-solaris"
IUSE="animgif gif jpeg png truetype xpm"

DEPEND=">=media-libs/gd-2.0.33
	png? (
		media-libs/gd[png]
		media-libs/libpng
		sys-libs/zlib
	)
	jpeg? (
		media-libs/gd[jpeg]
		virtual/jpeg
	)
	truetype? (
		media-libs/gd[truetype]
		media-libs/freetype:2
	)
	xpm? (
		media-libs/gd[xpm]
		x11-libs/libXpm
	)
	gif? ( media-libs/giflib )"

SRC_TEST=do

src_prepare(){
	perl-module_src_prepare
	sed -i "s/use Getopt::Long;/use Getopt::Long qw(:config pass_through);/" \
		"${S}"/Makefile.PL || die
}

src_configure() {
	myconf=""
	use gif && use animgif && myconf="${myconf},ANIMGIF"
	use jpeg && myconf="${myconf},JPEG"
	use truetype && myconf="${myconf},FREETYPE"
	use png && myconf="${myconf},PNG"
	use xpm && myconf="${myconf},XPM"
	use gif && myconf="${myconf},GIF"
	myconf="-options \"${myconf:1}\""
	perl-module_src_configure
}

src_test() {
	if use png || use jpeg || use gif ; then
		if has_version ">=media-libs/jpeg-7" || \
			has_version "media-libs/libjpeg-turbo" ; then
			# https://rt.cpan.org/Public/Bug/Display.html?id=49053
			ewarn "Tests fail with >=media-libs/jpeg-7 or media-libs/libjpeg-turbo. Skipping tests..."
			return
		fi
		perl-module_src_test
	else
		ewarn "The test fails if neither of png, jpeg, gif is in USE!"
		ewarn "Skipping tests..."
	fi
}
mydoc="GD.html"
