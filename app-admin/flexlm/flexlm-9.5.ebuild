# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/flexlm/flexlm-9.5.ebuild,v 1.3 2005/03/10 18:49:40 chrb Exp $

DESCRIPTION="Macrovision FLEXlm license manager and utils"
HOMEPAGE="http://www.macrovision.com/services/support/flexlm/lmgrd.shtml"
SRC_URI="ftp://ftp.globes.com/flexlm/unix/v${PV}/i86_s8/lmgrd.Z
	ftp://ftp.globes.com/flexlm/unix/v${PV}/i86_s8/lmutil.Z
	http://www.macrovision.com/services/support/flexlm/enduser.pdf"

LICENSE="Macromedia"
SLOT="0"
KEYWORDS="x86"
IUSE=""
RESTRICT="nostrip nomirror"

DEPEND="virtual/libc"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cp ${DISTDIR}/enduser.pdf ${S}
}

src_install () {
	# executables
	dodir /opt/flexlm/bin
	exeinto /opt/flexlm/bin
	doexe lmgrd lmutil
	# documentation
	dodir /opt/flexlm/doc
	insinto /opt/flexlm/doc
	doins enduser.pdf
	# init files
	exeinto /etc/init.d
	newexe ${FILESDIR}/flexlm-init flexlm
	# environment
	insinto /etc/env.d
	doins ${FILESDIR}/90flexlm
	# config
	insinto /etc/conf.d/
	newins ${FILESDIR}/flexlm-conf flexlm
	# empty dir for licenses
	dodir /etc/flexlm
}

pkg_postinst() {
	enewuser flexlm -1 /bin/bash /opt/flexlm nogroup "FlexLM server user"
	einfo "FlexLM installed. Config is in /etc/conf.d/flexlm"
	einfo "Default location for license file is /etc/flexlm/license.dat"
}
