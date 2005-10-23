# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/find/find-0.0.5.ebuild,v 1.1 2005/10/23 19:28:26 svyatogor Exp $

inherit rox

MY_PN="Find"
MY_PV=`echo ${PV} | sed -e 's/\.//g'`

DESCRIPTION="Find - A file Finder utility for ROX by Ken Hayber."
HOMEPAGE="http://www.hayber.us/rox/Find"
SRC_URI="http://www.hayber.us/rox/find/${MY_PN}-${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

ROX_LIB_VER=2.0.0

APPNAME=${MY_PN}
S=${WORKDIR}

