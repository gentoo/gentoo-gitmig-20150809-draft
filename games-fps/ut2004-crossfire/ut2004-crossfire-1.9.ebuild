# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-crossfire/ut2004-crossfire-1.9.ebuild,v 1.2 2009/04/18 00:06:21 nyhm Exp $

MOD_NAME="Crossfire"
MOD_DESC="Special Forces vs Terrorists"
MOD_DIR="TOCrossfire"
MOD_BINS="crossfire"
MOD_ICON="Help/icons/TOC_TERROR2.png"

inherit games games-mods

OLD="TOCrossfire_beta_1.9_full"
UPD="TOCrossfire_beta_1.9a_update"
HOMEPAGE="http://www.to-crossfire.net/"
SRC_URI="ftp://mirror1.to-crossfire.net/client/${OLD}.zip
	ftp://mirror1.to-crossfire.net/client/${OLD}.zip
	ftp://toc.de-mirror.org/client/${OLD}.zip
	ftp://mirror1.to-crossfire.net/client/${UPD}.zip
	ftp://mirror1.to-crossfire.net/client/${UPD}.zip
	ftp://toc.de-mirror.org/client/${UPD}.zip"

# See Help/EULA.txt
LICENSE="free-noncomm"

KEYWORDS="~amd64 ~x86"

RDEPEND="${CATEGORY}/${GAME}"

src_unpack() {
	mkdir ${OLD} ${UPD}

	cd "${WORKDIR}/${OLD}" && unpack "${OLD}.zip" || die
	cd "${WORKDIR}/${UPD}" && unpack "${UPD}.zip" || die
	cd "${WORKDIR}"
	unpack ./${OLD}/TOCinstall.tgz ./${UPD}/TOCinstall.tgz

	cd "${MOD_DIR}" || die
	rm -f *.{bat,exe,md5} Help/*.{exe,zip}
}
