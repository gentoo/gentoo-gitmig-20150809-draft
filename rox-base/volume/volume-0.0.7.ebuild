# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/volume/volume-0.0.7.ebuild,v 1.2 2005/11/19 18:34:33 svyatogor Exp $

MY_PN="Volume"
MY_PV=`echo "${PV}" | sed -e 's/\.//g'`
DESCRIPTION="Volume is a ROX Panel Applet that puts a popup volume control in your panel."
HOMEPAGE="http://www.hayber.us/rox/Volume"
SRC_URI="http://www.hayber.us/rox/applets/${MY_PN}-${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
		>=dev-python/pygtk-1.9.8"

ROX_VER=2.1.0
ROX_LIB_VER=2.0.0
APPNAME=${MY_PN}
S=${WORKDIR}

inherit rox
