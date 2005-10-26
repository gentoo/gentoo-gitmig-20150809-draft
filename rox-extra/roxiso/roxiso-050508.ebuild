# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/roxiso/roxiso-050508.ebuild,v 1.1 2005/10/26 13:48:59 svyatogor Exp $

MY_PN="RoxISO"

DESCRIPTION="RoxISO. A graphical frontend to mkisofs and cdrecord."
HOMEPAGE="http://kymatica.bitminds.net/software.html"
SRC_URI="http://kymatica.bitminds.net/rox/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="dvdr"

DEPEND="dvdr? ( app-cdr/cdrecord-prodvd )
		!dvdr? ( app-cdr/cdrtools ) "

ROX_CLIB_VER=1.9.13

APPNAME=RoxISO

S=${WORKDIR}

inherit rox
