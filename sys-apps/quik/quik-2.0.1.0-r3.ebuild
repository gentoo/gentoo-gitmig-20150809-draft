# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/quik/quik-2.0.1.0-r3.ebuild,v 1.4 2003/06/21 21:19:40 drobbins Exp $

inherit mount-boot

S="${WORKDIR}/quik-2.0"
HOMEPAGE=""
DESCRIPTION="OldWorld PowerMac Bootloader"
MY_P="quik_2.0e.orig.tar.gz"
DEB_P="quik_2.0e-1.diff"
DEB_URI="ftp://ftp.debian.org/debian/pool/main/q/quik"
SRC_URI="${DEB_URI}/${MY_P} ${DEB_URI}/${DEB_P}.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 -alpha -sparc -mips"

DEPEND="virtual/glibc"

PROVIDE="virtual/bootloader"

src_unpack() {
	cd ${WORKDIR}
	unpack ${MY_P} || die
	zcat ${DISTDIR}/${DEB_P}.gz | patch -p1 -d ${S}|| die
	[ -z "${CC}" ] && CC=gcc
	GCC_VERSION="`${CC} -dumpversion | cut -d. -f1,2,3`"
	einfo "GCC_VERSION: ${GCC_VERSION}"
	cd ${S}/quik
	# this patch fixes bug #14817
	einfo "Fixing missing fclose()"
	patch -p1 < ${FILESDIR}/quik-2.0.1.0-fclose-bug.patch || die "patch failed"
	if [ "${GCC_VERSION}" != "2.95" ] ; then
		cd ${S}/second
		patch -p1 < ${FILESDIR}/quik-2.0.1.0-gcc-321.patch || die "patch failed"
		cp Makefile Makefile.orig
		sed -e s:'$(LD) $(LDFLAGS) -Bstatic -o second $(OBJS) -lext2fs':'$(LD) $(LDFLAGS) -Bstatic -o second $(OBJS) -lext2fs -lc -lgcc -L/usr/lib/gcc-lib/powerpc-unknown-linux-gnu/'${GCC_VERSION}/: Makefile.orig > Makefile

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
