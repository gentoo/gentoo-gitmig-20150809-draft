# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/zipper/zipper-0.9.ebuild,v 1.3 2005/08/25 18:57:12 swegener Exp $

inherit gnustep

S=${WORKDIR}/${PN/z/Z}

DESCRIPTION="Zipper is a tool for inspecting the contents of a compressed archive and for extracting."
HOMEPAGE="http://xanthippe.dyndns.org/Zipper/"
SRC_URI="http://xanthippe.dyndns.org/Zipper/${P/z/Z}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"

IUSE=""
DEPEND="${GS_DEPEND}
	gnustep-libs/renaissance
	gnustep-libs/objcunit"
RDEPEND="${GS_RDEPEND}
	app-arch/tar
	app-arch/unzip
	app-arch/lha
	app-arch/unlzx"
# what to do about rar? unrar doesn't seem to work right, and rar is intel only

egnustep_install_domain "System"
