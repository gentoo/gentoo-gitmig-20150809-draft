# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cel-cvs/cel-cvs-0.97.ebuild,v 1.6 2004/02/20 07:44:01 mr_bones_ Exp $

inherit cvs
ECVS_SERVER="cvs.cel.sourceforge.net:/cvsroot/cel"
ECVS_MODULE="cel"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
S=${WORKDIR}/${ECVS_MODULE}

DESCRIPTION="A game entity layer based on Crystal Space"
HOMEPAGE="http://cel.sourceforge.net/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="dev-games/crystalspace
	>=sys-apps/sed-4
	dev-util/jam
	!dev-games/cel-cvs"

CEL_PREFIX=/opt/crystal
CS_PREFIX=/opt/crystal

src_compile() {
	./autogen.sh || die
	env PATH="${CEL_PREFIX}/bin:${PATH}" ./configure \
		--prefix=${CEL_PREFIX} --with-cs-prefix=${CEL_PREFIX} || die
	jam || die
}

src_install() {
	sed -i -e "s:/usr/local/cel:${CEL_PREFIX}:g" cel.cex
	# attention don't put a / between ${D} and ${CEL_PREFIX} jam has a bug where
	# it fails with 3 following slashes.
	jam -sFILEMODE=0644 -sEXEMODE=0755 -sprefix=${D}${CEL_PREFIX} install || die
	dobin cel.cex
}
