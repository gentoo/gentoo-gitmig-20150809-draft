# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/omake/omake-0.9.8.5.ebuild,v 1.1 2007/08/23 09:16:48 aballier Exp $

inherit eutils toolchain-funcs multilib

EXTRAPV="-3"
DESCRIPTION="Make replacement"
HOMEPAGE="http://omake.metaprl.org/"
SRC_URI="http://omake.metaprl.org/downloads/${P}${EXTRAPV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc fam ncurses readline"
DEPEND=">=dev-lang/ocaml-3.0.8
	ncurses? ( >=sys-libs/ncurses-5.3 )
	fam? ( virtual/fam )
	readline? ( >=sys-libs/readline-4.3 )"

use_boolean() {
	if use $1; then
		echo "true"
	else
		echo "false"
	fi
}

src_compile() {
	# Configuration steps...
	echo "PREFIX = \$(dir \$\"/usr\")" > .config
	echo "BINDIR = \$(dir \$\"\$(PREFIX)/bin\")" >> .config
	echo "LIBDIR = \$(dir \$\"\$(PREFIX)/$(get_libdir)\")" >> .config
	echo "MANDIR = \$(dir \$\"\$(PREFIX)/man\")" >> .config

	echo "CC = $(tc-getCC)" >> .config
	echo "CFLAGS = ${CFLAGS}" >> .config

	echo "NATIVE_ENABLED = true" >> .config
	echo "BYTE_ENABLED = false" >> .config

	echo "NATIVE_PROFILE = false" >> .config

	echo "READLINE_ENABLED = $(use_boolean readline)" >> .config
	echo "FAM_ENABLED = $(use_boolean fam)" >> .config
	echo "NCURSES_ENABLED = $(use_boolean ncurses)" >> .config

	echo "DEFAULT_SAVE_INTERVAL = 60" >> .config

	echo "OCAMLDEP_MODULES_ENABLED = false" >> .config

	emake all || die "compilation failed"
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "emake install failed"
	dodoc CHANGELOG.txt
	if use doc; then
		dodoc doc/ps/omake-doc.{pdf,ps} doc/txt/omake-doc.txt
		dohtml -r doc/html/*
	fi
}
