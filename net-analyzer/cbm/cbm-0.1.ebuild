# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cbm/cbm-0.1.ebuild,v 1.1 2012/10/23 11:52:16 pinkbyte Exp $

EAPI=4

inherit base

DESCRIPTION="Display the current traffic on all network devices"
HOMEPAGE="http://www.isotton.com/software/unix/cbm/"
SRC_URI="http://www.isotton.com/software/unix/${PN}/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-libs/ncurses"
DEPEND="${RDEPEND}
	app-text/xmlto
	app-text/docbook-xml-dtd:4.4"

PATCHES=( "${FILESDIR}/${PN}-gcc-4.3.patch" )
