# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/roxcd/roxcd-0.4.5.ebuild,v 1.1 2004/12/09 18:22:20 sergey Exp $

DESCRIPTION="RoxCD - A CD Player/Ripper for the ROX Desktop"

MY_PN="RoxCD"

HOMEPAGE="http://www.rdsarts.com/code/roxcd"

SRC_URI="http://www.rdsarts.com/code/roxcd/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""

ROX_LIB_VER=1.9.11

APPNAME=${MY_PN}

S=${WORKDIR}

inherit rox
