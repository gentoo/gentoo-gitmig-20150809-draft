# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/nwipe/nwipe-0.06.ebuild,v 1.1 2012/01/16 16:29:37 ssuominen Exp $

EAPI=4

DESCRIPTION="Securely erase disks using a variety of recognized methods"
HOMEPAGE="http://sourceforge.net/projects/nwipe/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="sys-block/parted
	sys-libs/ncurses"
DEPEND="${RDEPEND}"

DOCS="README"
