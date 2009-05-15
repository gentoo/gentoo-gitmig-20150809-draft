# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/dmg2img/dmg2img-1.3.ebuild,v 1.2 2009/05/15 08:29:41 fauli Exp $

DESCRIPTION="Converts Apple DMG files to standard HFS+ images"
HOMEPAGE="http://vu1tur.eu.org/tools"
SRC_URI="http://vu1tur.eu.org/tools/download.pl?${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_install() {
	# Install the Program
	exeinto /usr/sbin
	doexe dmg2img
	doexe vfdecrypt
	# Install the Readme
	dodoc README
}
