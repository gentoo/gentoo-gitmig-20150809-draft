# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/openmosixview/openmosixview-1.2.ebuild,v 1.1 2002/09/18 17:52:51 tantive Exp $


S=${WORKDIR}/openmosixview
DESCRIPTION="cluster-management GUI for OpenMosix"
SRC_URI="www.openmosixview.com/download/openmosixview-${PV}.tar.gz"
HOMEPAGE="http://www.openmosixview.com"

DEPEND=">=x11-libs/qt-2.3.0
	>=sys-apps/openmosix-user-0.2.4
	>=sys-kernel/openmosix-sources-2.4.18"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 -ppc -sparc -sparc64"

src_unpack() {
        unpack ${A}
	cat > configuration << EOF

        # test which version of qt is installed
        if [ -d /usr/qt/3 ]; then
	    QTDIR=/usr/qt/3; else
            QTDIR=/usr/qt/2;
        fi

	CC=gcc
EOF
}

src_compile() {
	cd ${S}
	./configure || die
	make || die

	cd ${S}/openmosixcollector
	./configure || die
	make || die
	
	cd ${S}/openmosixanalyzer
	./configure || die
	make || die
	
	cd ${S}/openmosixhistory
	./configure || die
	make || die
	
	cd ${S}/openmosixprocs
	./configure || die
	make || die
}

src_install () {
        dodir /usr/sbin
	dodir /usr/local/bin

        make INSTALLBASEDIR=${D}usr INSTALLMANDIR=${D}usr/share/man DESTDIR=${D} INSTALLDIR=${D}usr install || die
	cd ${S}/openmosixcollector
        make INSTALLBASEDIR=${D}usr INSTALLMANDIR=${D}usr/share/man DESTDIR=${D} INSTALLDIR=${D}usr install || die
	cd ${S}/openmosixanalyzer
        make INSTALLBASEDIR=${D}usr INSTALLMANDIR=${D}usr/share/man DESTDIR=${D} INSTALLDIR=${D}usr install || die
	cd ${S}/openmosixhistory
        make INSTALLBASEDIR=${D}usr INSTALLMANDIR=${D}usr/share/man DESTDIR=${D} INSTALLDIR=${D}usr install || die
	cd ${S}/openmosixprocs
        make INSTALLBASEDIR=${D}usr INSTALLMANDIR=${D}usr/share/man DESTDIR=${D} INSTALLDIR=${D}usr install || die
    
        dodoc COPYING README

        exeinto /etc/init.d
	newexe ${S}/openmosixcollector/openmosixcollector.init openmosixcollector
}

pkg_postinst() {
	einfo
	einfo "Openmosixview will allow you to monitor all nodes in your cluster."
	einfo
	einfo "You will need ssh to all cluster-nodes without password."
	einfo
	einfo "To setup your other nodes you will have to copy the openmosixprocs binary to them:"
	einfo "scp /usr/local/bin/openmosixprocs your_node:/usr/local/bin/openmosixprocs"
	einfo
	einfo "Start openmosixcollector manually (/etc/init.d/openmosixcollector start) or"
	einfo "automatically using rc-update (rc-update add /etc/init.d/openmosixcollector default)."
	einfo
	einfo "Start openmosixview by simply typing openmosixview"
	einfo
}
