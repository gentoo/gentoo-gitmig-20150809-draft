# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/adjtimex/adjtimex-1.16-r1.ebuild,v 1.2 2004/08/01 20:58:41 dholm Exp $

inherit fixheadtails eutils

DEBIAN_PV="1"
MY_P="${P/-/_}"
DEBIAN_URI="mirror://debian/pool/main/${PN:0:1}/${PN}"
DEBIAN_PATCH="${MY_P}-${DEBIAN_PV}.diff.gz"
DEBIAN_SRC="${MY_P}.orig.tar.gz"
DESCRIPTION="adjtimex - display or set the kernel time variables"
HOMEPAGE="http://www.ibiblio.org/linsearch/lsms/adjtimex.html"
SRC_URI="${DEBIAN_URI}/${DEBIAN_PATCH}
		 ${DEBIAN_URI}/${DEBIAN_SRC}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="virtual/libc"
DEPEND="${RDEPEND} sys-apps/sed"

src_unpack() {
	unpack ${DEBIAN_SRC}
	epatch ${DISTDIR}/${DEBIAN_PATCH}
	cd ${S}
	for i in debian/adjtimexconfig debian/adjtimexconfig.8 ; do
		sed -e 's|/etc/default/adjtimex|/etc/conf.d/adjtimex|' -i ${i}
		sed -e 's|^/sbin/adjtimex |/usr/sbin/adjtimex |' -i ${i}
	done
	ht_fix_file debian/adjtimexconfig
	sed -e '/CFLAGS = -Wall -t/,/endif/d' -i Makefile.in
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	dodoc README* COPYING COPYRIGHT ChangeLog
	doman adjtimex.8 debian/adjtimexconfig.8
	dosbin adjtimex debian/adjtimexconfig
	exeinto /etc/init.d
	newexe ${FILESDIR}/adjtimex.init adjtimex
}

pkg_postinst() {
	einfo "Please run adjtimexconfig to create the configuration file"
}
