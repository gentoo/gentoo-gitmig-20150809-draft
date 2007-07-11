# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vimoutliner/vimoutliner-0.3.4.ebuild,v 1.2 2007/07/11 05:14:07 mr_bones_ Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: easy and fast outlining"
HOMEPAGE="http://www.vimoutliner.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="vimoutliner"
VIM_PLUGIN_MESSAGES="filetype"

src_unpack() {
	unpack ${A}
	cd ${S}
	find ${S} -type f | xargs chmod a+r
}

src_install() {
	cd ${S}
	p=/usr/share/vim/vimfiles
	for d in doc ftdetect ftplugin syntax ; do
		dodir ${p}/${d}
		cp -R ${d} ${D}/${p}/
	done

	dodir ${p}/vimoutliner/plugins
	cp -R add-ons/plugins ${D}/${p}/vimoutliner/

	for d in scripts/* add-ons/scripts/* ; do
		dobin ${d}
	done

	dodoc vimoutlinerrc
}
