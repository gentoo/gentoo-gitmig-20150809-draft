# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-3.0.1.20020604.ebuild,v 1.1 2002/06/05 19:14:09 danarmak Exp $

inherit kde-patch kde-dist

DESCRIPTION="${DESCRIPTION}Network"

# copied from kde.org.eclass because I'm to lazy to change it, will change sometime though
SRC_PATH="kde/stable/${PV}/src/post-3.0.1-kdenetwork.diff"
SRC_URI="$SRC_URI
		ftp://ftp.kde.org/pub/$SRC_PATH
		ftp://download.us.kde.org/pub/kde/$SRC_PATH
		ftp://download.uk.kde.org/pub/kde/$SRC_PATH
		ftp://download.au.kde.org/pub/kde/$SRC_PATH
		ftp://download.at.kde.org/pub/kde/$SRC_PATH
		ftp://ftp.fh-heilbronn.de/pub/mirrors/$SRC_PATH
		ftp://ftp.sourceforge.net/pub/mirrors/$SRC_PATH"


src_unpack() {

    cd ${WORKDIR}
    unpack ${P}.tar.bz2
    
    cd ${S}
    patch -p1 < ${DISTDIR}/post-3.0.1-kdenetwork.diff || die
    
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

