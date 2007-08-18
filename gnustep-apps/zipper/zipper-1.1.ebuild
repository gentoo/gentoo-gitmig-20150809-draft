# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnustep-apps/zipper/zipper-1.1.ebuild,v 1.2 2007/08/18 15:29:43 angelos Exp $

inherit gnustep

S=${WORKDIR}/${PN/z/Z}

DESCRIPTION="Zipper is a tool for inspecting and extracting compressed archives"
HOMEPAGE="http://xanthippe.dyndns.org/Zipper/"
SRC_URI="http://xanthippe.dyndns.org/Zipper/${P/z/Z}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

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
