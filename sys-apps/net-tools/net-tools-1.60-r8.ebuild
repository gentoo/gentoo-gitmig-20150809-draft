# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/net-tools/net-tools-1.60-r8.ebuild,v 1.1 2004/03/29 07:34:04 seemant Exp $

inherit eutils

DESCRIPTION="Standard Linux networking tools"
SRC_URI="http://www.tazenda.demon.co.uk/phil/net-tools/${P}.tar.bz2
	mirror://gentoo/${P}-gentoo-extra-1.tar.bz2"
HOMEPAGE="http://sites.inka.de/lina/linux/NetTools/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~amd64 ~ia64 ~ppc64 ~s390"
IUSE="nls build static"

DEPEND="nls? ( sys-devel/gettext )
	>=sys-apps/sed-4"

src_unpack() {

	if [ "`use static`" ] ; then
		CFLAGS="${CFLAGS} -static"
		LDFLAGS="${LDFLAGS} -static"
	fi

	PATCHDIR=${WORKDIR}/${P}-gentoo

	unpack ${A}
	cd ${S}

	# Compile fix for 2.6 kernels
	epatch ${FILESDIR}/net-tools-1.60-2.6-compilefix.patch

	epatch ${FILESDIR}/net-tools-1.60-cleanup-list-handling.patch

	# some redhat patches
	epatch ${PATCHDIR}/net-tools-1.54-ipvs.patch
	epatch ${PATCHDIR}/net-tools-1.57-bug22040.patch
	epatch ${PATCHDIR}/net-tools-1.60-manydevs.patch
	epatch ${PATCHDIR}/net-tools-1.60-miiioctl.patch
	epatch ${PATCHDIR}/net-tools-1.60-virtualname.patch
	epatch ${PATCHDIR}/net-tools-1.60-cycle.patch

	# GCC-3.3 Compile Fix
	epatch ${PATCHDIR}/${P}-multiline-string.patch

	# manpage fix #29677
	epatch ${FILESDIR}/${PV}-man.patch

	cp ${PATCHDIR}/net-tools-1.60-config.h config.h
	cp ${PATCHDIR}/net-tools-1.60-config.make config.make

	sed -i \
		-e "s:-O2 -Wall -g:${CFLAGS}:" \
		-e "/^LOPTS =/ s/\$/${CFLAGS}/" Makefile ||
			die "sed Makefile failed"

	sed -i -e "s:/usr/man:/usr/share/man:" man/Makefile || \
		die "sed man/Makefile failed"

	cp -f ${PATCHDIR}/ether-wake.c ${S}
	cp -f ${PATCHDIR}/ether-wake.8 ${S}/man/en_US

	if [ -z "`use nls`" ] ; then
		sed -i -e 's:\(#define I18N\) 1:\1 0:' config.h || \
			die "sed config.h failed"

		sed -i -e 's:I18N=1:I18N=0:' config.make ||
			die "sed config.make failed"
	fi

	touch config.{h,make}		# sync timestamps
}

src_compile() {
	# Changing "emake" to "make" closes half of bug #820;
	# configure is run from *inside* the Makefile, sometimes
	# breaking parallel makes (if ./configure doesn't finish first)
	make || die

	if [ "`use nls`" ] ; then
		cd po
		make || die
	fi

	cd ${S}
	gcc ${CFLAGS} -o ether-wake ether-wake.c || die
}

src_install() {
	make BASEDIR=${D} install || die

	dosbin ether-wake
	mv ${D}/bin/* ${D}/sbin
	for i in hostname domainname netstat dnsdomainname ypdomainname nisdomainname
	do
		mv ${D}/sbin/${i} ${D}/bin
	done
	dodir /usr/bin
	dosym /bin/hostname /usr/bin/hostname

	if [ -z "`use build`" ]
	then
		dodoc COPYING README README.ipv6 TODO
	else
		#only install /bin/hostname
		rm -rf ${D}/usr
		rm -rf ${D}/sbin
		rm -f ${D}/bin/{domainname,netstat,dnsdomainname}
		rm -f ${D}/bin/{ypdomainname,nisdomainname}
	fi
}
