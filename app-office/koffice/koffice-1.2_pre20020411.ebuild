# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.2_pre20020411.ebuild,v 1.1 2002/04/11 19:06:55 verwilst Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-base || die

need-kde 3

S=${WORKDIR}/${PN}
DESCRIPTION="KDE Office Set"
HOMEPAGE="http://www.koffice.org/"
SLOT="0"

SRC_URI="http://www.ibiblio.org/gentoo/distfiles/koffice-20020411.tar.bz2"

DEPEND="$DEPEND
	>=dev-lang/python-2.0-r5"


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


