# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/otpcalc/otpcalc-0.96.ebuild,v 1.1 2003/09/05 13:10:29 taviso Exp $

DESCRIPTION="A One Time Password and S/Key calculator for X"
HOMEPAGE="http://killa.net/infosec/otpCalc/"
SRC_URI="http://killa.net/infosec/otpCalc/otpCalc-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-*"

IUSE=""
RDEPEND="=x11-libs/gtk+-1.2*
		virtual/x11
		virtual/glibc"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}

src_install() {
	sed -e "s/VERSION/${PV}/g" otpCalc.man > otpCalc.1
	doman otpCalc.1
	dobin otpCalc
}
