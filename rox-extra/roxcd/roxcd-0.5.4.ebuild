# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/roxcd/roxcd-0.5.4.ebuild,v 1.2 2006/11/17 14:57:33 lack Exp $

ROX_LIB_VER=1.9.14
inherit rox

MY_PN="RoxCD"
DESCRIPTION="RoxCD - A CD Player/Ripper for the ROX Desktop"
HOMEPAGE="http://www.rdsarts.com/code/roxcd"
SRC_URI="http://www.rdsarts.com/code/roxcd/files/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

APPNAME=${MY_PN}
S=${WORKDIR}

#YUCK, there is a subdiretory in Help for the Licenses.
#need to move it
src_unpack() {
	unpack ${A}
	cd ${APPNAME}/Help
	mv Licenses-Text/* ./
	rm -fr Licenses-Text
}
