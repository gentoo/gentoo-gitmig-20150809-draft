# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-boot/quik/quik-2.0.1.0-r1.ebuild,v 1.7 2004/11/06 03:57:54 dragonheart Exp $

inherit toolchain-funcs mount-boot

S="${WORKDIR}/quik-2.0"
HOMEPAGE=""
DESCRIPTION="OldWorld PowerMac Bootloader"
MY_P="quik_2.0e.orig.tar.gz"
DEB_P="quik_2.0e-1.diff"
DEB_URI="ftp://ftp.debian.org/debian/pool/main/q/quik"
SRC_URI="${DEB_URI}/${MY_P} ${DEB_URI}/${DEB_P}.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="ppc -x86 -amd64 -alpha -hppa -mips -sparc"
IUSE=""

DEPEND="virtual/libc"

PROVIDE="virtual/bootloader"

src_unpack() {
	cd ${WORKDIR}
	unpack ${MY_P} || die
	zcat ${DISTDIR}/${DEB_P}.gz | patch -p1 -d ${S}|| die
	[ -z "${CC}" ] && CC=$(tc-getCC)
	if [ "`${CC} -dumpversion | cut -d. -f1,2`" != "2.95" ] ; then
		cd ${S}/second
		cp Makefile Makefile.orig
		sed -e s:'$(LD) $(LDFLAGS) -Bstatic -o second $(OBJS) -lext2fs':'$(LD) $(LDFLAGS) -Bstatic -o second $(OBJS) -lext2fs -lc -lgcc -L/usr/lib/gcc-lib/powerpc-unknown-linux-gnu/3.2/': Makefile.orig > Makefile

	fi
}

src_compile() {
	emake || die
}

src_install() {
	#i'll have a look at this later
	install -d -m 755 ${D}/sbin || die
	install -d -m 755 ${D}/etc || die
	install -d -m 755 ${D}/boot || die
	install -d -m 755 ${D}/usr/share/man/man5 || die
	install -d -m 755 ${D}/usr/share/man/man8 || die
	install -s -m 755 quik/quik ${D}/sbin || DIE
	install -m 644 man/quik.conf.5 \
			${D}/usr/share/man/man5 || DIE
	install -m 644 man/quik.8 man/bootstrap.8 \
			${D}/usr/share/man/man8 || DIE

	install -m 444 first/first.b second/second.b \
					second/second ${D}/boot || die
	install -m 644 etc/quik.conf ${D}/etc || die
}
