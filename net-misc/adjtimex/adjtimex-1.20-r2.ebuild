# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/adjtimex/adjtimex-1.20-r2.ebuild,v 1.4 2007/04/04 20:15:09 ferdy Exp $

inherit fixheadtails eutils

DEBIAN_PV="6"
MY_P="${P/-/_}"
DEBIAN_URI="mirror://debian/pool/main/${PN:0:1}/${PN}"
DEBIAN_PATCH="${MY_P}-${DEBIAN_PV}.diff.gz"
DEBIAN_SRC="${MY_P}.orig.tar.gz"
DESCRIPTION="display or set the kernel time variables"
HOMEPAGE="http://www.ibiblio.org/linsearch/lsms/adjtimex.html"
SRC_URI="${DEBIAN_URI}/${DEBIAN_PATCH}
	${DEBIAN_URI}/${DEBIAN_SRC}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ppc x86"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND} sys-apps/sed"

src_unpack() {
	unpack ${DEBIAN_SRC}
	epatch ${DISTDIR}/${DEBIAN_PATCH}
	cd ${S}
	for i in debian/adjtimexconfig debian/adjtimexconfig.8 ; do
		sed -e 's|/etc/default/adjtimex|/etc/conf.d/adjtimex|' \
			-i.orig ${i}
		sed -e 's|^/sbin/adjtimex |/usr/sbin/adjtimex |' \
			-i.orig ${i}
	done
	epatch ${FILESDIR}/${PN}-1.20-gentoo-utc.patch
	ht_fix_file debian/adjtimexconfig
	sed -e '/CFLAGS = -Wall -t/,/endif/d' -i Makefile.in
	epatch ${FILESDIR}/${PN}-1.16-pic.patch
	epatch ${FILESDIR}/${PN}-1.20-fix-syscall.patch
}

src_install() {
	dodoc README* ChangeLog
	doman adjtimex.8 debian/adjtimexconfig.8
	dosbin adjtimex debian/adjtimexconfig
	exeinto /etc/init.d
	newexe ${FILESDIR}/adjtimex.init adjtimex
}

pkg_postinst() {
	einfo "Please run adjtimexconfig to create the configuration file"
}
