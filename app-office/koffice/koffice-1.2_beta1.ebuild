# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.2_beta1.ebuild,v 1.1 2002/04/26 06:45:15 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 3

S="${WORKDIR}/koffice-1.2-beta1"
DESCRIPTION="KDE Office Set"
HOMEPAGE="http://www.koffice.org/"

SRC_URI="http://www.gentoo.org/~verwilst/koffice-1.2-beta1.tar.bz2"

DEPEND="$DEPEND
	>=dev-lang/python-2.2"


src_unpack() {

	unpack koffice-1.2-beta1.tar.bz2
	cd ${S}/kword
	patch -p0 < ${FILESDIR}/${P}-kwdoc.diff
	patch -p0 < ${FILESDIR}/${P}-kwcanvas.diff
	patch -p0 < ${FILESDIR}/${P}-kwtableframeset.diff
	patch -p0 < ${FILESDIR}/${P}-kwtextframeset.diff
	patch -p0 < ${FILESDIR}/${P}-kwtextframeset.h.diff

}

src_compile() {

    export LIBPYTHON="`python-config --libs`"
    export LIBPYTHON="${LIBPYTHON//-L \/usr\/lib\/python2.2\/config}"

    myconf="$myconf --enable-all"
    kde_src_compile myconf

    #the dir kchar/kdchart cannot be compiled with the -fomit-frame-pointer flag present
    CFLAGS2="$CFLAGS"
    CXXFLAGS2="$CXXFLAGS"

    CFLAGS=${CFLAGS/-fomit-frame-pointer}
    CXXFLAGS=${CXXFLAGS/-fomit-frame-pointer}

    cd ${S}
    kde_src_compile configure
    cd kchart/kdchart
    emake || die

    cd ${S}
    CFLAGS="$CFLAGS2"
    CXXFLAGS="$CXXFLAGS2"
    kde_src_compile configure
    emake || die

}


