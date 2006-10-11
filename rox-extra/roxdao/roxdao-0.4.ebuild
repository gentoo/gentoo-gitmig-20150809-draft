# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/roxdao/roxdao-0.4.ebuild,v 1.1 2006/10/11 13:47:47 lack Exp $

ROX_LIB_VER=2.0.3
inherit rox

MY_PN="RoxDAO"
DESCRIPTION="RoxDAO: A graphical frontend to cdrdao for the ROX Desktop."
HOMEPAGE="http://kymatica.com/software.html"
SRC_URI="http://kymatica.com/rox/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="app-cdr/cdrdao
	rox-extra/mp3ogg2wav"

APPNAME=${MY_PN}
S=${WORKDIR}
