# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.2_beta2.ebuild,v 1.7 2002/09/15 09:43:07 danarmak Exp $
inherit kde-base

need-kde 3

S="${WORKDIR}/koffice-1.2-beta2"
DESCRIPTION="A free, integrated office suite for KDE, the K Desktop Environment."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"
SRC_URI="ftp://ftp.kde.org/pub/kde/unstable/koffice-1.2-beta2/src/koffice-1.2-beta2.tar.bz2"

KEYWORDS="x86 ppc"

DEPEND="$DEPEND
	>=dev-lang/python-2.2.1
	>=media-libs/libart_lgpl-2.3.9
	>=media-gfx/imagemagick-5.4.5"

export LIBPYTHON="`python-config --libs`"
export LIBPYTHON="${LIBPYTHON//-L \/usr\/lib\/python2.2\/config}"

need-automake 1.5
need-autoconf 2.5


src_compile() {

    myconf="$myconf --enable-final"
    kde_src_compile myconf configure

    #the dir kchar/kdchart cannot be compiled with the -fomit-frame-pointer flag present
    kde_remove_flag kchart/kdchart -fomit-frame-pointer
    kde_remove_flag kugar/kudesigner -fomit-frame-pointer # bug 4572

    kde_src_compile make
	
}

