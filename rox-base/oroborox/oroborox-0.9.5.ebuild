# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-base/oroborox/oroborox-0.9.5.ebuild,v 1.1 2004/12/01 15:27:02 sergey Exp $

DESCRIPTION="OroboROX is a small window manager for the ROX Desktop."

HOMEPAGE="http://rox.sourceforge.net/"

MY_PN="OroboROX"

SRC_URI="http://roxos.sunsite.dk/dev-contrib/guido/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

S=${WORKDIR}

ROX_LIB_VER=1.9.14

APPNAME=${MY_PN}

inherit rox
