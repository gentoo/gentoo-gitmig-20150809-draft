# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.3_beta3.ebuild,v 1.3 2003/09/08 02:30:47 caleb Exp $
inherit kde-base flag-o-matic

# TODO : mysql support
# other refs from configure: jasper, qt-docs, doxygen, libxml2, libxslt, freetype, fontconfig, qt being built with sql support (???)

filter-flags "-fomit-frame-pointer"

need-kde 3

MY_P=${PN}-1.2.92

DESCRIPTION="A free, integrated office suite for KDE, the K Desktop Environment."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/unstable/${MY_P}/src/${MY_P}.tar.bz2"
PATCHES="${FILESDIR}/${P}-gcc33.diff"

S="$WORKDIR/${MY_P}"

KEYWORDS="~x86"

DEPEND="$DEPEND
	>=dev-lang/python-2.2.1
	>=media-libs/libart_lgpl-2.3.9
	>=media-gfx/imagemagick-5.4.5
	>=app-text/wv2-0.1.8
	dev-util/pkgconfig"

export LIBPYTHON="`python-config --libs`"
export LIBPYTHON="${LIBPYTHON//-L \/usr\/lib\/python2.2\/config}"

need-automake 1.5
need-autoconf 2.5

