# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-2.2.2-r1.ebuild,v 1.8 2002/12/09 04:25:04 manson Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - network apps: kmail..."
KEYWORDS="x86 sparc "

src_unpack() {

    base_src_unpack
    kde_sandbox_patch ${S}/kppp

}
src_install() {

    kde_src_install
    
    chmod +s ${D}/${KDEDIR}/bin/reslisa

}
