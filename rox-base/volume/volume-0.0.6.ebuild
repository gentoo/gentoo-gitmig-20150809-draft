# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/volume/volume-0.0.6.ebuild,v 1.3 2005/10/17 09:41:46 svyatogor Exp $

DESCRIPTION="Volume - A Volume control Applet and a Mixer for ROX Desktop"

MY_PN="Volume"

MY_PV="006"

HOMEPAGE="http://www.hayber.us/rox/Volume"

SRC_URI="http://www.hayber.us/rox/applets/${MY_PN}-${MY_PV}.tgz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

ROX_LIB_VER=1.9.11

APPNAME=${MY_PN}

S=${WORKDIR}

inherit rox
