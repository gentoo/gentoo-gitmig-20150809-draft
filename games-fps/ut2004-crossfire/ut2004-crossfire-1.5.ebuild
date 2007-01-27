# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-fps/ut2004-crossfire/ut2004-crossfire-1.5.ebuild,v 1.2 2007/01/27 00:50:44 mr_bones_ Exp $

MOD_NAME="Crossfire"
MOD_DESC="Special Forces vs Terrorists"
MOD_DIR="TOCrossfire"
MOD_BINS="crossfire"
MOD_ICON=Help/icons/TOC_TERROR2.png

inherit games games-mods

HOMEPAGE="http://www.to-crossfire.net/"
SRC_URI="ftp://mirror1.to-crossfire.net/client/TOCrossfire_beta1.2_full.zip
	ftp://mirror1.to-crossfire.net/client/TOCrossfire_beta${PV}_update.zip
	http://www.speicherland.com/TOCrossfire_beta${PV}_update.zip"

# See /opt/ut2004/TOCrossfire/Help/EULA.txt
LICENSE="free-noncomm"

KEYWORDS="~amd64 ~x86"

RDEPEND="${CATEGORY}/${GAME}"

src_unpack() {
	games-mods_src_unpack

	unpack ./TOCrossfire_beta_1.2_full/TOCinstall.tgz
	unpack ./TOCrossfire_beta${PV}_update/TOCinstall.tgz

	cd "${MOD_DIR}" || die
	rm -f *.exe Help/*.{exe,zip}
}
