# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-3.0.2.ebuild,v 1.5 2002/08/01 19:44:15 gerk Exp $
inherit kde-dist

DESCRIPTION="KDE $PV - network apps: kmail..."
KEYWORDS="x86 ppc"

src_unpack() {

    cd ${WORKDIR}
    unpack ${P}.tar.bz2
    
    kde_sandbox_patch ${S}/kppp

}

src_install() {

    kde_src_install
    
    chmod +s ${D}/${KDEDIR}/bin/reslisa
    
    # empty config file needed for lisa to work with default settinsg
    touch ${D}/etc/lisarc
    
    # lisa, reslisa initscripts
    dodir /etc/init.d
    sed -e "s:_KDEDIR_:${KDEDIR}:g" ${FILESDIR}/lisa > ${D}/etc/init.d/lisa
    sed -e "s:_KDEDIR_:${KDEDIR}:g" ${FILESDIR}/reslisa > ${D}/etc/init.d/reslisa
    
    insinto /etc/conf.d
    newins ${FILESDIR}/lisa.conf lisa
    newins ${FILESDIR}/reslisa.conf reslisa

}

