# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/adjtimex/adjtimex-1.16.ebuild,v 1.1 2004/01/06 04:13:02 robbat2 Exp $

inherit fixheadtails

DEBIAN_PV="1"
DESCRIPTION="adjtimex - display or set the kernel time variables"
HOMEPAGE="http://www.ibiblio.org/linsearch/lsms/adjtimex.html"
SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN}/${P/-/_}-${DEBIAN_PV}.diff.gz
		 mirror://debian/pool/main/${PN:0:1}/${PN}/${P/-/_}.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc"

S="${WORKDIR}/${P}"

src_unpack() {
	unpack ${P/-/_}.orig.tar.gz
	epatch ${DISTDIR}/${P/-/_}-${DEBIAN_PV}.diff.gz
	cd ${S}
	for i in debian/adjtimexconfig debian/adjtimexconfig.8 ; do
		sed -e 's|/etc/default/adjtimex|/etc/conf.d/adjtimex|' -i ${i}
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
