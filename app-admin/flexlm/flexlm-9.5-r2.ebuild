# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/flexlm/flexlm-9.5-r2.ebuild,v 1.1 2012/04/16 10:37:21 pacho Exp $

EAPI=4
inherit eutils

DESCRIPTION="Macrovision FLEXlm license manager and utils"
HOMEPAGE="http://www.macrovision.com/services/support/flexlm/lmgrd.shtml"
SRC_URI="http://www.macrovision.com/services/support/flexlm/enduser.pdf
	x86? (
		mirror://gentoo/lmgrd-x86.Z
		mirror://gentoo/lmutil-x86.Z
	)
	amd64? (
		mirror://gentoo/lmgrd-amd64.Z
		mirror://gentoo/lmutil-amd64.Z
	)"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""
RESTRICT="strip"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	mv lmutil-${ARCH} lmutil
	mv lmgrd-${ARCH} lmgrd

	cp "${DISTDIR}"/enduser.pdf "${S}"
}

src_install () {
	# executables
	dodir /opt/flexlm/bin
	exeinto /opt/flexlm/bin
	doexe lmgrd lmutil

	dosym lmutil /opt/flexlm/bin/lmcksum
	dosym lmutil /opt/flexlm/bin/lmdiag
	dosym lmutil /opt/flexlm/bin/lmdown
	dosym lmutil /opt/flexlm/bin/lmhostid
	dosym lmutil /opt/flexlm/bin/lmremove
	dosym lmutil /opt/flexlm/bin/lmreread
	dosym lmutil /opt/flexlm/bin/lmstat
	dosym lmutil /opt/flexlm/bin/lmver

	# documentation
	dodoc enduser.pdf

	# init files
	newinitd "${FILESDIR}"/flexlm-init flexlm
	newconfd "${FILESDIR}"/flexlm-conf flexlm

	# environment
	doenvd "${FILESDIR}"/90flexlm

	# empty dir for licenses
	keepdir /etc/flexlm

	# log dir
	dodir /var/log/flexlm
}

pkg_postinst() {
	enewgroup flexlm
	enewuser flexlm -1 /bin/bash /opt/flexlm flexlm

	# See bug 383787
	chown flexlm /var/log/flexlm || die

	elog "FlexLM installed. Config is in /etc/conf.d/flexlm"
	elog "Default location for license file is /etc/flexlm/license.dat"
}
