# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/roxget/roxget-0.0.5c.ebuild,v 1.3 2005/03/06 00:00:28 josejx Exp $

DESCRIPTION="ROXget - Download Handler for the ROX Desktop"

MY_PN="ROXget"

MY_PV="005c"

HOMEPAGE="http://nipul.digitillogic.net/"

SRC_URI="http://nipul.digitillogic.net/${MY_PN}-${MY_PV}.tgz"

LICENSE="MIT"

SLOT="0"

KEYWORDS="~x86 ~ppc"

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
