# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/man/man-1.5i-r3.ebuild,v 1.11 2003/05/25 15:10:30 mholzer Exp $

NV=1.5i2
S=${WORKDIR}/${PN}-${NV}
DESCRIPTION="Standard commands to read man pages"
SRC_URI="mirror://kernel/linux/utils/man/man-${NV}.tar.gz"
HOMEPAGE="http://freshmeat.net/projects/man/"
DEPEND="virtual/glibc"

RDEPEND="virtual/glibc
	sys-apps/cronbase
	sys-apps/groff"


SLOT="0"
KEYWORDS="x86 ppc sparc "
LICENSE="GPL-2"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp configure configure.orig
	sed -e 's/confdir=.*$/confdir=\/etc/' \
		-e 's:/usr/lib/locale:$prefix/usr/lib/locale:g' \
		-e 's!/bin:/usr/bin:/usr/ucb:/usr/local/bin:$PATH!/bin:/usr/bin:/usr/local/bin:$PATH!' \
		configure.orig > configure
	local x
	for x in / src/ man2html/ msgs/
	do
		cd ${S}/${x}
		cp Makefile.in Makefile.in.orig
		sed -e '/inst.sh/d' \
			-e '/^CC =/c\' \
			-e "CC = gcc" \
			-e '/^CFLAGS =/c\' \
			-e "CFLAGS = $CFLAGS" \
			Makefile.in.orig > Makefile.in
	done
}

src_compile() {
	./configure +sgid +fhs +lang all || die
	#for FOOF in src man2html
	#do
	#	pmake ${FOOF}/Makefile MANCONFIG=/etc/man.conf || die
	#	cd ${S}/${FOOF}
	#	cp Makefile Makefile.orig
	#	sed -e "s/gcc -O/gcc ${CFLAGS}/" Makefile.orig > Makefile
	#	cd ${S}
	#done
	make || die
}

src_install() {
	dodir /usr/sbin /usr/bin
	cd ${S}
	make PREFIX=${D} install || die
	cd ${S}/msgs
	./inst.sh ?? ${D}/usr/share/locale/%L/%N
	chmod 2555 ${D}/usr/bin/man
	chown root.man ${D}/usr/bin/man
	insinto /etc
	cd ${S}
	doins src/man.conf
	dodoc COPYING LSM README* TODO
	
	exeinto /etc/cron.daily
	doexe ${FILESDIR}/makewhatis.cron
	
}


