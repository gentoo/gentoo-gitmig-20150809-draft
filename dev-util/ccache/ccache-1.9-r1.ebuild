# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/ccache/ccache-1.9-r1.ebuild,v 1.9 2003/09/06 08:39:20 msterret Exp $

DESCRIPTION="ccache is a fast compiler cache. It is used as a front end to your
compiler to safely cache compilation output. When the same code is compiled
again the cached output is used giving a significant speedup."
SRC_URI="http://ccache.samba.org/ftp/ccache/${P}.tar.gz"
HOMEPAGE="http://ccache.samba.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc mips"

# Note: this version is designed to be auto-detected and used if you happen to have Portage
# 2.0.6+ installed.

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

	if([ -e /usr/bin/gcc ]) then
		ln -s ccache gcc
	fi

	if([ -e /usr/bin/cc ]) then
		ln -s ccache cc
	fi

	if([ -e /usr/bin/c++ ]) then
		ln -s ccache c++
	fi

	if([ -e /usr/bin/g++ ]) then
		ln -s ccache g++
	fi

	if([ -e /usr/bin/${CHOST}-gcc ]) then
		ln -s ccache ${CHOST}-gcc
	fi

	if([ -e /usr/bin/${CHOST}-c++ ]) then
		ln -s ccache ${CHOST}-c++
	fi

	if([ -e /usr/bin/${CHOST}-g++ ]) then
		ln -s ccache ${CHOST}-g++
	fi

	if [ ! -d ${ROOT}root/.ccache ]
	then
		install -d -m0700 ${ROOT}root/.ccache
	fi


	einfo "To use ccache with **non-Portage** C compiling, add /usr/bin/ccache to your path before /usr/bin."
	einfo "Portage 2.0.6+ will automatically take advantage of ccache with no additional steps."
	einfo "If this is your first install of ccache, type something like this to set a maximum"
	einfo "cache size of 2GB (or whatever you desire):"
	einfo "# /usr/bin/ccache/ccache -M 2G"
}


