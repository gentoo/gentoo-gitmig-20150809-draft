# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/volume/volume-007.ebuild,v 1.1 2005/12/22 21:35:10 svyatogor Exp $

MY_PN="Volume"
DESCRIPTION="Volume is a ROX Panel Applet that puts a popup volume control in your panel."
HOMEPAGE="http://www.hayber.us/rox/Volume"
SRC_URI="http://www.hayber.us/rox/applets/${MY_PN}-${PV}.tgz"

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
