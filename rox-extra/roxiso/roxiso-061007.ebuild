# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/roxiso/roxiso-061007.ebuild,v 1.1 2006/10/11 13:13:38 lack Exp $

ROX_LIB_VER=1.9.13
inherit rox

MY_PN="RoxISO"

DESCRIPTION="RoxISO. A graphical frontend to mkisofs and cdrecord."
HOMEPAGE="http://kymatica.com/rox/software.html"
SRC_URI="http://kymatica.com/rox/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="app-cdr/cdrtools"

APPNAME=RoxISO
S="${WORKDIR}"
