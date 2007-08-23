# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/omake/omake-0.9.6.5.ebuild,v 1.5 2007/08/23 09:07:41 aballier Exp $

inherit eutils

EXTRAPV="-2"
DESCRIPTION="Make replacement"
HOMEPAGE="http://omake.metaprl.org/"
SRC_URI="http://omake.metaprl.org/downloads/${P}${EXTRAPV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ppc ~amd64"
IUSE="fam readline"
DEPEND=">=dev-lang/ocaml-3.0.8
	>=sys-libs/ncurses-5.3
	fam? ( virtual/fam )
	readline? ( >=sys-libs/readline-4.3 )"

use_boolean() {
	if use $1; then
		echo "true"
	else
		echo "false"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e "s/Ae/Aexyz/g" OMakefile
}

src_compile() {
	make boot

	cat ${FILESDIR}/omake-config > .config
	echo "CFLAGS = " ${CFLAGS} > .config
	echo "FAM_ENABLED = " $(use_boolean fam) > .config
	echo "READLINE_ENABLED = " $(use_boolean readline) > .config

	PREFIX=/usr	OMAKEFLAGS= ./omake-boot --dotomake .omake --force-dotomake -j2 -S --progress main || die "Bootstrapping failed"

	PREFIX=/usr OMAKEFLAGS= src/main/omake --dotomake .omake \
		--force-dotomake -j2 -S --progress all doc \
		|| die "omake failed"
}

src_install() {
	INSTALL_ROOT=${D} OMAKEFLAGS= src/main/omake \
		--dotomake .omake --force-dotomake -j2 install
}
