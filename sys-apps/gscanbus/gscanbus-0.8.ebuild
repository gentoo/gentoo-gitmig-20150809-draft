# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/gscanbus/gscanbus-0.8.ebuild,v 1.4 2012/02/24 14:28:03 phajdan.jr Exp $

EAPI=4

DESCRIPTION="a little bus scanning, testing, and topology visualizing tool for the Linux IEEE1394 subsystem"
HOMEPAGE="http://gscanbus.berlios.de/"
SRC_URI="mirror://berlios/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ~sparc x86"
IUSE=""

RDEPEND="sys-libs/libraw1394
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS=( AUTHORS README TODO )
