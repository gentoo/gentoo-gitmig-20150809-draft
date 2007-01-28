# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/pikdev/pikdev-0.9.2.1.ebuild,v 1.2 2007/01/28 06:16:34 genone Exp $

inherit kde versionator

MY_P=${PN}-$(replace_version_separator 3 '-' )
DESCRIPTION="Graphical IDE for PIC-based application development"
HOMEPAGE="http://pikdev.free.fr/"
SRC_URI="http://pikdev.free.fr/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="arts"
S="${WORKDIR}/${MY_P}"

# need-kde adds kde-libs,qt,.. rdependencies 
# why this lengthy list?
# A. overzealous
RDEPEND="sys-libs/zlib
	dev-libs/expat
	media-libs/fontconfig
	media-libs/freetype
	media-libs/jpeg
	media-libs/libart_lgpl
	media-libs/libmng
	media-libs/libpng
	dev-embedded/gputils
	>=kde-base/kdelibs-3
	arts? ( kde-base/arts )"

# Ebuild will evily link to these if present
#	media-libs/nas


need-kde 3

src_compile() {
	myconf="$myconf $(useenable arts)"
	kde_src_compile myconf configure
	sed -i -e "s#\(kde_.* = \)\${prefix}\(.*\)#\1${KDEDIR}\2#g" Makefile */Makefile
	kde_src_compile make
}

src_install() {
	kde_src_install all
}

pkg_postinst() {
	elog "The author requests that you email him at alain.gibaud@free.fr when you"
	elog "install this package. See http://pikdev.free.fr/download.php3 for details"

	ewarn "CAUTION: If you already have a previous version of PiKdev, do not forget to delete the"
	ewarn " ~/.kde/share/apps/pikdev directory before installing the new version. This directory"
	ewarn " contains a local copy of configuration files and prevents new functionnalities to appear"
	ewarn " in menus/toolbars."
}
