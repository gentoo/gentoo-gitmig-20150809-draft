# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/genkernel/genkernel-3.3.11d.ebuild,v 1.1 2006/04/14 14:48:38 plasmaroo Exp $

VERSION_DMAP='1.00.17'
VERSION_DMRAID='1.0.0.rc10'
VERSION_E2FSPROGS='1.38'
VERSION_LVM2='2.00.25'
VERSION_PKG='3.3.11a'
VERSION_UNIONFS='1.1.4'
VERSION_UDEV="077"
VERSION_KLIBC="1.2.1"

DESCRIPTION="Gentoo autokernel script"
HOMEPAGE="http://www.gentoo.org"
SRC_URI="http://dev.gentoo.org/~plasmaroo/patches/kernel/genkernel/${P}.tar.bz2
	http://dev.gentoo.org/~plasmaroo/patches/kernel/genkernel/genkernel-pkg-${VERSION_PKG}.tar.bz2
	http://people.redhat.com/~heinzm/sw/dmraid/src/dmraid-${VERSION_DMRAID}.tar.bz2
	ftp://sources.redhat.com/pub/lvm2/old/LVM2.${VERSION_LVM2}.tgz
	ftp://sources.redhat.com/pub/dm/old/device-mapper.${VERSION_DMAP}.tgz
	ftp://ftp.fsl.cs.sunysb.edu/pub/unionfs/unionfs-${VERSION_UNIONFS}.tar.gz
	mirror://sourceforge/e2fsprogs/e2fsprogs-${VERSION_E2FSPROGS}.tar.gz
	mirror://kernel/linux/utils/kernel/hotplug/udev-${VERSION_UDEV}.tar.bz2
	http://www.kernel.org/pub/linux/libs/klibc/Testing/klibc-${VERSION_KLIBC}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
#KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sparc x86"
IUSE="ibm"

DEPEND="sys-fs/e2fsprogs"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	unpack ${PN}-pkg-${VERSION_PKG}.tar.bz2
}

src_install() {
	dodir /etc
	cp ${S}/genkernel.conf ${D}/etc
	# This block updates genkernel.conf
	sed -i -e "s:VERSION_DMAP:$VERSION_DMAP:" \
		-e "s:VERSION_DMRAID:$VERSION_DMRAID:" \
		-e "s:VERSION_E2FSPROGS:$VERSION_E2FSPROGS:" \
		-e "s:VERSION_LVM2:$VERSION_LVM2:" \
		-e "s:VERSION_UNIONFS:$VERSION_UNIONFS:" \
		-e "s:VERSION_UDEV:$VERSION_UDEV:" \
		-e "s:VERSION_KLIBC:$VERSION_KLIBC:" \
		${D}/etc/genkernel.conf || die "Could not adjust versions"

	# This is because I switched to using the bzip2 for klibc
	sed -i -e 's:KLIBC_VER}.tar.gz:KLIBC_VER}.tar.bz2:' \
		${D}/etc/genkernel.conf || die "Could not adjust klibc tarball"
	sed -i -e 's:tar zxpf "${KLIBC_SRCTAR}":tar jxpf "${KLIBC_SRCTAR}":' \
		${S}/gen_compile.sh || die "sed gen_compile.sh"

	dodir /usr/share/genkernel
	use ibm && cp ${S}/ppc64/kernel-2.6-pSeries ${S}/ppc64/kernel-2.6 || cp ${S}/ppc64/kernel-2.6.g5 ${S}/ppc64/kernel-2.6
	cp -Rp ${S}/* ${D}/usr/share/genkernel

	dodir /usr/bin
	dosym /usr/share/genkernel/genkernel /usr/bin/genkernel

	rm ${D}/usr/share/genkernel/genkernel.conf
	dodoc README

	doman genkernel.8
	rm genkernel.8

	cp ${DISTDIR}/dmraid-${VERSION_DMRAID}.tar.bz2 \
	${DISTDIR}/LVM2.${VERSION_LVM2}.tgz \
	${DISTDIR}/device-mapper.${VERSION_DMAP}.tgz \
	${DISTDIR}/unionfs-${VERSION_UNIONFS}.tar.gz \
	${DISTDIR}/e2fsprogs-${VERSION_E2FSPROGS}.tar.gz \
	${DISTDIR}/klibc-${VERSION_KLIBC}.tar.bz2 \
	${DISTDIR}/udev-${VERSION_UDEV}.tar.bz2 \
	${D}/usr/share/genkernel/pkg
}

pkg_postinst() {
	echo
	einfo 'Documentation is available in the genkernel manual page'
	einfo 'as well as the following URL:'
	echo
	einfo 'http://www.gentoo.org/doc/en/genkernel.xml'
	echo
	ewarn "This package is known to not work with reiser4.  If you are running"
	ewarn "reiser4 and have a problem, do not file a bug.  We know it does not"
	ewarn "work and we don't plan on fixing it since reiser4 is the one that is"
	ewarn "broken in this regard.  Try using a sane filesystem like ext3 or"
	ewarn "even reiser3."
	echo
}
