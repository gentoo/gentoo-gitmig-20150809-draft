# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/otpcalc/otpcalc-0.97-r1.ebuild,v 1.5 2006/04/19 13:35:40 taviso Exp $

inherit eutils

DESCRIPTION="A One Time Password and S/Key calculator for X"
HOMEPAGE="http://killa.net/infosec/otpCalc/"
SRC_URI="http://killa.net/infosec/otpCalc/otpCalc-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ppc sparc x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2* virtual/libc"

S=${WORKDIR}/${P/c/C}

src_unpack() {
	unpack ${A}; cd ${S}

	epatch ${FILESDIR}/otpcalc-man-table-format.diff
	epatch ${FILESDIR}/otpcalc-0.97-badindex.diff
	epatch ${FILESDIR}/otpcalc-crypto-proto.diff

	# print correct version in manpage
	sed -i -e "s/VERSION/${PV}/g" ${S}/otpCalc.man

	# override hardcoded CFLAGS
	sed -i "s#-s -O3#${CFLAGS}#g" ${S}/Makefile.in
}

src_install() {
	newman otpCalc.man otpCalc.1
	dobin otpCalc
}
