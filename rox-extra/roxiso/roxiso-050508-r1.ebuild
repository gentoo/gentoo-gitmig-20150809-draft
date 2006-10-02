# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/rox-extra/roxiso/roxiso-050508-r1.ebuild,v 1.1 2006/10/02 13:32:20 lack Exp $

inherit rox eutils

MY_PN="RoxISO"

DESCRIPTION="RoxISO. A graphical frontend to mkisofs and cdrecord."
HOMEPAGE="http://kymatica.bitminds.net/software.html"
SRC_URI="http://kymatica.bitminds.net/rox/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="app-cdr/cdrtools"

ROX_CLIB_VER=1.9.13

APPNAME=RoxISO
S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-config_location.patch
}
