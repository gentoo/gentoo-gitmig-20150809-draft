# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.0.1.20020604.ebuild,v 1.2 2002/07/11 06:30:26 drobbins Exp $

inherit kde-patch kde-dist

DESCRIPTION="${DESCRIPTION}Educational"

src_unpack() {

    base_src_unpack
    
    kde_sandbox_patch ${S}/klettres/klettres

}

src_compile() {

    # build fails with -fomit-frame-pointer optimization in kgeo
    
    CFLAGS2="$CFLAGS"
    CXXFLAGS2="$CXXFLAGS"
    CFLAGS=${CFLAGS/-fomit-frame-pointer}
    CXXFLAGS=${CXXFLAGS/-fomit-frame-pointer}
    
    kde_src_compile myconf configure
    
    cd ${S}/kgeo
    emake || die
    
    CFLAGS="$CFLAGS2"
    CXXFLAGS="$CXXFLAGS2"
    
    kde_src_compile all

}
