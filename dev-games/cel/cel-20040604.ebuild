# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-games/cel/cel-20040604.ebuild,v 1.2 2004/06/06 03:32:03 mr_bones_ Exp $

inherit eutils

DESCRIPTION="A game entity layer based on Crystal Space"
HOMEPAGE="http://cel.sourceforge.net/"
SRC_URI="mirror://gentoo/distfiles/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""

RDEPEND="dev-games/crystalspace
	dev-util/jam
	!dev-games/cel-cvs
	python? ( virtual/python )"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

S=${WORKDIR}/${PN}

CEL_PREFIX=/opt/crystal
CS_PREFIX=/opt/crystal

src_unpack() {
	unpack ${A}
#	cd ${S}
#	epatch ${FILESDIR}/${P}-install.patch
}

src_compile() {
#	./autogen.sh || die
	MY_CONF=" --prefix=${CEL_PREFIX} --with-cs-prefix=${CS_PREFIX} "
#	if use python; then
#		MY_CONF="${MY_CONF} --with-python"
#	else
#		einfo "compiling without python"
#		MY_CONF="${MY_CONF} --without-python"
#	fi
	# doesn't compile with python atm (2.3)
	# FIXME: need to try with other versions of python which might work
	MY_CONF="${MY_CONF} --without-python"

	env PATH="${CEL_PREFIX}/bin:${PATH}" ./configure ${MY_CONF} || die

	jam || die
}

src_install() {
#	sed -i -e "s:/usr/local/cel:${CEL_PREFIX}:g" cel.cex
	# attention don't put a / between ${D} and ${CEL_PREFIX} jam has a bug where
	# it fails with 3 following slashes.
	jam -sFILEMODE=0644 -sEXEMODE=0755 -sprefix=${D}${CEL_PREFIX} install || die
	dobin cel.cex
}
