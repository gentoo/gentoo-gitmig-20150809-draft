# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdeedu/kdeedu-3.1_alpha1.ebuild,v 1.3 2002/07/13 18:49:00 danarmak Exp $
inherit kde-dist

DESCRIPTION="${DESCRIPTION}Educational"

PATCHES="$FILESDIR/$P-errno.diff"

#src_unpack() {
#
#    base_src_unpack
#    
#    kde_sandbox_patch ${S}/klettres/klettres
#
#}

#src_compile() {
#
#    # build fails with -fomit-frame-pointer optimization in kgeo
#    
#    CFLAGS2="$CFLAGS"
#    CXXFLAGS2="$CXXFLAGS"
#    CFLAGS=${CFLAGS/-fomit-frame-pointer}
#    CXXFLAGS=${CXXFLAGS/-fomit-frame-pointer}
#    
#    kde_src_compile myconf configure
#    
#    cd ${S}/kgeo
#    emake || die
#    
#    CFLAGS="$CFLAGS2"
#    CXXFLAGS="$CXXFLAGS2"
#    
#    kde_src_compile all
#
#}
