# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mosix-user/mosix-user-1.5.7.ebuild,v 1.7 2002/08/01 11:40:16 seemant Exp $

S=${WORKDIR}/user
DESCRIPTION="User-land utilities for MOSIX process migration (clustering) software"
SRC_URI="http://www.mosix.cs.huji.ac.il/ftps/MOSIX-${PV}.tar.gz"
HOMEPAGE="http://www.mosix.org"
KEYWORDS="x86 -ppc"
SLOT="0"
LICENSE="as-is"
DEPEND=">=sys-libs/ncurses-5.2"

src_unpack() {
	mkdir ${S}; cd ${S}
	tar -xz --no-same-owner -f ${DISTDIR}/${A} MOSIX-${PV}/user.tar MOSIX-${PV}/manuals.tar	
	mv MOSIX-${PV}/*.tar .
	rm -rf MOSIX-${PV}
	tar -x --no-same-owner -f user.tar -C ${S}	
	tar -x --no-same-owner -f manuals.tar -C ${S}
}

src_compile() {
	cd ${S}
	local x
	for x in lib/moslib sbin/setpe sbin/tune bin/mosrun usr.bin/mon usr.bin/migrate usr.bin/mosctl
	do
		cd $x
		make || die
		cd ../..
	done
}

src_install () {
	cd ${S}
	make ROOT=${D} PREFIX=${D}/usr install
	dodir /usr/share	
	cd ${D}/usr
	mv man share	
	exeinto /etc/init.d
	newexe ${FILESDIR}/mosix.init mosix
	insinto /etc
	#stub mosix.map file
	doins ${FILESDIR}/mosix.map
	cd ${S}
	doman man?/*
}

pkg_postinst() {
	echo
	echo " To complete MOSIX installation, edit /etc/mosix.map and then type:
	echo "# rc-update add mosix default
	echo " ...to add MOSIX to the default runlevel.  This particular version of"
	echo " mosix-user has been designed to work with the 2.4.13 kernel."
	echo
}
