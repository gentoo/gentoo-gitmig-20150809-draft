# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/otpcalc/otpcalc-0.96.ebuild,v 1.4 2003/09/06 22:08:32 msterret Exp $

DESCRIPTION="A One Time Password and S/Key calculator for X"
HOMEPAGE="http://killa.net/infosec/otpCalc/"
SRC_URI="http://killa.net/infosec/otpCalc/otpCalc-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha"

IUSE=""
RDEPEND="=x11-libs/gtk+-1.2*
		virtual/x11
		virtual/glibc"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P/c/C}

src_unpack() {
	unpack ${A}
	sed -e "s/VERSION/${PV}/g" ${S}/otpCalc.man > ${S}/otpCalc.1
	sed -i "s#-s -O3#${CFLAGS}#g" ${S}/Makefile.in
}

src_install() {
	sed -e "s/VERSION/${PV}/g" ${S}/otpCalc.man > ${S}/otpCalc.1
	doman otpCalc.1
	dobin otpCalc
}
