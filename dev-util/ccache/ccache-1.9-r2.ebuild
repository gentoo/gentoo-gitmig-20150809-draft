# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ccache/ccache-1.9-r2.ebuild,v 1.4 2003/09/06 08:39:20 msterret Exp $

DESCRIPTION="ccache is a fast compiler cache. It is used as a front end to your
compiler to safely cache compilation output. When the same code is compiled
again the cached output is used giving a significant speedup."
SRC_URI="http://ccache.samba.org/ftp/ccache/${P}.tar.gz"
HOMEPAGE="http://ccache.samba.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa"

# Note: this version is designed to be auto-detected and used if
# you happen to have Portage 2.0.6+ installed.

src_compile() {
	./configure --prefix=${D}/usr || die
	make || die
}

src_install () {
	exeinto /usr/bin/ccache
	doexe ccache
	doman ccache.1
	dodoc COPYING README
}

pkg_postinst() {
	cd /usr/bin/ccache

	# Search the PATH now that gcc doesn't live in /usr/bin
	einfo "Scanning for compiler front-ends"
	for a in gcc cc c++ g++ ${CHOST}-gcc ${CHOST}-c++ ${CHOST}-g++; do
		type -ap ${a} && ln -s ccache ${a}
	done

	if [ ! -d ${ROOT}root/.ccache ]
	then
		install -d -m0700 ${ROOT}root/.ccache
	fi

	einfo "To use ccache with **non-Portage** C compiling, add"
	einfo "/usr/bin/ccache to your path before /usr/bin.  Portage 2.0.6+"
	einfo "will automatically take advantage of ccache with no additional"
	einfo "steps.  If this is your first install of ccache, type something"
	einfo "like this to set a maximum cache size of 2GB (or whatever you"
	einfo "desire):"
	einfo "# /usr/bin/ccache/ccache -M 2G"
}
