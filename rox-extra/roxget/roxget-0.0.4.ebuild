# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/roxget/roxget-0.0.4.ebuild,v 1.1 2004/12/18 12:27:29 sergey Exp $

DESCRIPTION="ROXget - Download Handler for the ROX Desktop"

MY_PN="ROXget"

MY_PV="004"

HOMEPAGE="http://nipul.dyn.ee/Projects/ROX/ROXget"

SRC_URI="http://www.digitillogic.net/${MY_PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

DEPEND="dev-python/urlgrabber"

ROX_LIB_VER=1.9.16

APPNAME=${MY_PN}

S=${WORKDIR}/${MY_PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd ${MY_PN}-${MY_PV}
	mkdir ${APPNAME}
	mv * ${APPNAME}/
}

inherit rox
