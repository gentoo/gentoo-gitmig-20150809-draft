# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mosix-user/mosix-user-1.0.5.ebuild,v 1.1 2001/07/13 02:13:32 drobbins Exp $

S=${WORKDIR}/user
DESCRIPTION="User-land utilities for MOSIX process migration (clustering) software"
SRC_URI="ftp://ftp.cs.huji.ac.il/users/mosix/MOSIX-${PV}.tar.gz"
HOMEPAGE="http://www.mosix.org"
DEPEND="virtual/glibc >=sys-libs/ncurses-5.2"

src_unpack() {
	mkdir ${WORKDIR}/user
	cd ${WORKDIR}
	tar -xz --no-same-owner -f ${DISTDIR}/${A} user.tar manuals.tar	
	tar -x --no-same-owner -f user.tar -C ${S}	
	tar -x --no-same-owner -f manuals.tar -C ${S}
}

src_compile() {
	cd ${S}
	local x
	for x in lib/moslib sbin/setpe sbin/tune bin/mosrun usr.bin/mon usr.bin/migrate usr.bin/mosctl
	do
		cd $x
		make
		cd ../..
	done
}

src_install () {
	cd ${S}
	dodir /usr/lib /usr/include
	dolib.a libmos.a
	dolib.so libmos.so.0
	ln -s libmos.so.0 ${D}/usr/lib/libmos.so
	insinto /usr/include
	doins *.h

	cd ../../sbin/setpe
	doman setpe.1
	into /
	dosbin setpe

	cd ../tune
	dosbin tune mtune tunepass tune_kernel prep_tune
	doman tune.1

	cd ../../bin/mosrun
	dobin mosrun nomig runhome runon cpujob iojob nodecay slowdecay fastdecay
	doman mosrun.1
	local x
	for x in nomig runhome runon cpujob iojob nodecay slowdecay fastdecay
	do
		ln -s mosrun.1.gz ${D}/usr/share/man/man1/${x}.1.gz
	done

	cd ../../usr.bin/mon
	into /usr
	dobin mon
	doman mon.1

	cd ../migrate
	dobin migrate
	doman migrate.1

	cd ../mosctl
	dobin mosctl
	doman mosctl.1

	exeinto /etc/rc.d/init.d
	newexe ${FILESDIR}/mosix.init-${PV} mosix
	cd ${S}
	doman man?/*
}

