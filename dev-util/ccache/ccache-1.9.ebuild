# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/ccache/ccache-1.9.ebuild,v 1.2 2002/07/10 00:44:03 gerk Exp $

DESCRIPTION="ccache is a fast compiler cache. It is used as a front end to your
compiler to safely cache compilation output. When the same code is compiled
again the cached output is used giving a significant speedup."
SRC_URI="http://ccache.samba.org/ftp/ccache/${P}.tar.gz"
HOMEPAGE="http://ccache.samba.org/"
KEYWORDS="x86 ppc"

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
	cd ${D}/usr/bin/ccache
	ln -s ccache gcc
	ln -s ccache cc
	ln -s ccache c++
	ln -s ccache g++
	ln -s ccache ${CHOST}-c++
	ln -s ccache ${CHOST}-g++
	ln -s ccache ${CHOST}-gcc
}

pkg_postinst() {
	if [ ! -d ${ROOT}root/.ccache ]
	then
		install -d -m0700 ${ROOT}root/.ccache
	fi
	einfo "To use ccache, add /usr/bin/ccache to your path before /usr/bin."
	einfo "Portage 2.0.6+ will automatically take advantage of ccache with no additional steps."
	einfo "If this is your first install of ccache, type something like this to set a maximum"
	einfo "cache size of 2GB (or whatever you desire):"
	einfo "# /usr/bin/ccache/ccache -M 2G"
}


