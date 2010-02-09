# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/poppler-utils/poppler-utils-0.8.7.ebuild,v 1.7 2010/02/09 11:25:42 yngwin Exp $

EAPI=2

DESCRIPTION="Virtual package, includes packages that contain the psto* utilities"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="m68k ~mips"
IUSE="+abiword"

PROPERTIES="virtual"

RDEPEND="~app-text/poppler-${PV}"
DEPEND="${RDEPEND}"
