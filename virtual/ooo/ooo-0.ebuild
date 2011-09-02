# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/ooo/ooo-0.ebuild,v 1.5 2011/09/02 10:20:40 scarabeus Exp $

EAPI=4

DESCRIPTION="Virtual for OpenOffice.org/LibreOffice"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""
RDEPEND="
	|| (
		app-office/libreoffice-bin
		app-office/libreoffice
	)
"
