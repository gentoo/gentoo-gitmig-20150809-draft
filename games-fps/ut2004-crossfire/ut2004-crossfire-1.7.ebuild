# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-crossfire/ut2004-crossfire-1.7.ebuild,v 1.1 2007/05/22 16:49:03 nyhm Exp $

MOD_NAME="Crossfire"
MOD_DESC="Special Forces vs Terrorists"
MOD_DIR="TOCrossfire"
MOD_BINS="crossfire"
MOD_ICON="Help/icons/TOC_TERROR2.png"

inherit games games-mods

OLD="TOCrossfire_beta1.6_full"
UPD="TOCrossfire_beta${PV}_update"
HOMEPAGE="http://www.to-crossfire.net/"
SRC_URI="ftp://mirror1.to-crossfire.net/client/${OLD}.zip
	ftp://toc.de-mirror.org/client/${OLD}.zip
	ftp://mirror1.to-crossfire.net/client/${UPD}.zip
	ftp://toc.de-mirror.org/client/${UPD}.zip"

# See Help/EULA.txt
LICENSE="free-noncomm"

KEYWORDS="~amd64 ~x86"

RDEPEND="${CATEGORY}/${GAME}"

src_unpack() {
	games-mods_src_unpack

	unpack ./${OLD/beta/beta_}/TOCinstall.tgz
	unpack ./${UPD}/TOCinstall.tgz

	cd "${MOD_DIR}" || die
	rm -f *.{bat,exe,md5} Help/*.{exe,zip}
}
