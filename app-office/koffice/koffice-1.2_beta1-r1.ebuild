# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Bart Verwilst <verwilst@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/app-office/koffice/koffice-1.2_beta1-r1.ebuild,v 1.3 2002/05/21 18:14:07 danarmak Exp $

inherit kde-base || die

need-kde 3

S="${WORKDIR}/koffice-1.2-beta1"
DESCRIPTION="A free, integrated office suite for KDE, the K Desktop Environment."
HOMEPAGE="http://www.koffice.org/"

SRC_URI="ftp://ftp.kde.org/pub/kde/unstable/koffice-1.2-beta1/src/koffice-1.2-beta1.tar.bz2"

DEPEND="$DEPEND
	>=dev-lang/python-2.2-r7"


src_unpack() {

	unpack koffice-1.2-beta1.tar.bz2
	cd ${S}/kword
	
	# This fixes the doc compilation error.. Seems kinda ugly, but beta2 will fix this#
	cd ${S}/doc/kformula
	mv index.docbook index.docbook.orig
        sed 's:XML V4.1.2-Based Variant V1.1:XML V4.1-Based Variant V1.0:' index.docbook.orig > index.docbook
        rm -f index.docbook.orig
	cd ${S}/doc/koffice
        mv index.docbook index.docbook.orig
	sed 's:XML V4.1.2-Based Variant V1.1:XML V4.1-Based Variant V1.0:' index.docbook.orig > index.docbook
        rm -f index.docbook.orig
	cd ${S}/doc/kontour
        mv index.docbook index.docbook.orig
	sed 's:XML V4.1.2-Based Variant V1.1:XML V4.1-Based Variant V1.0:' index.docbook.orig > index.docbook
        rm -f index.docbook.orig
	cd ${S}/doc/koshell
        mv index.docbook index.docbook.orig
	sed 's:XML V4.1.2-Based Variant V1.1:XML V4.1-Based Variant V1.0:' index.docbook.orig > index.docbook
        rm -f index.docbook.orig
	cd ${S}/doc/kpresenter
        mv index.docbook index.docbook.orig
	sed 's:XML V4.1.2-Based Variant V1.1:XML V4.1-Based Variant V1.0:' index.docbook.orig > index.docbook
        rm -f index.docbook.orig
	cd ${S}/doc/kspread
        mv index.docbook index.docbook.orig
	sed 's:XML V4.1.2-Based Variant V1.1:XML V4.1-Based Variant V1.0:' index.docbook.orig > index.docbook
        rm -f index.docbook.orig
	cd ${S}/doc/kugar
        mv index.docbook index.docbook.orig
	sed 's:XML V4.1.2-Based Variant V1.1:XML V4.1-Based Variant V1.0:' index.docbook.orig > index.docbook
        rm -f index.docbook.orig
	cd ${S}/doc/kword
        mv index.docbook index.docbook.orig
	sed 's:XML V4.1.2-Based Variant V1.1:XML V4.1-Based Variant V1.0:' index.docbook.orig > index.docbook
        rm -f index.docbook.orig
	cd ${S}/doc/thesaurus
        mv index.docbook index.docbook.orig
	sed 's:XML V4.1.2-Based Variant V1.1:XML V4.1-Based Variant V1.0:' index.docbook.orig > index.docbook
        rm -f index.docbook.orig

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


