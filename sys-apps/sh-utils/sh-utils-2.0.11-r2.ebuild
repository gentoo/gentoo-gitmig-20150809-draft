# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Daniel Robbins <drobbins@gentoo.org> 
# $Header: /var/cvsroot/gentoo-x86/sys-apps/sh-utils/sh-utils-2.0.11-r2.ebuild,v 1.1 2002/03/14 22:27:00 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Your standard GNU shell utilities"
SRC_URI="ftp://alpha.gnu.org/gnu/fetish/${P}.tar.gz http://www2.cddc.vt.edu/linux/utils/shell/nuname-1.0.tar.gz"

DEPEND="virtual/glibc nls? ( sys-devel/gettext )"

RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${P}.tar.gz
	tar zxf ${DISTDIR}/nuname-1.0.tar.gz
	cd ${S}
	patch src/uname.c ../nuname/lin_uname_patch
	mv ../nuname/README ../nuname/README.nuname
}

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"
	CFLAGS="${CFLAGS}" ./configure --host=${CHOST} --build=${CHOST} \
	--prefix=/usr --mandir=/usr/share/man --infodir=/usr/share/info \
	--without-included-regex ${myconf} || die
	
	if [ -z "`use static`" ]
	then
		emake || die
	else
		emake LDFLAGS=-static || die
	fi
}

src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share/man infodir=${D}/usr/share/info install || die
	rm -rf ${D}/usr/lib
	dodir /bin
	cd ${D}/usr/bin
	mv date echo false pwd stty su true uname sleep ${D}/bin

	if [ -z "`use build`" ]
	then
		# We must use hostname from net-base
		rm ${D}/usr/bin/hostname
		cd ${S}
		dodoc AUTHORS COPYING ChangeLog ChangeLog.0 NEWS README THANKS TODO 
		dodoc ../nuname/README.nuname
	else
		rm -rf ${D}/usr/share
	fi
	#we use the /bin/su from the sys-apps/shadow package
	rm ${D}/bin/su
	rm ${D}/usr/share/man/man1/su.1.gz
	#we use the /usr/bin/uptime from the sys-apps/procps package
	rm ${D}/usr/bin/uptime
	rm ${D}/usr/share/man/man1/uptime.1.gz
}
