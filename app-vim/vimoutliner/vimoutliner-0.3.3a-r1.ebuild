# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vimoutliner/vimoutliner-0.3.3a-r1.ebuild,v 1.10 2010/10/07 04:10:59 leio Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: easy and fast outlining"
HOMEPAGE="http://www.vimoutliner.org"
SRC_URI="mirror://gentoo/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ~mips ppc sparc x86"
IUSE=""

VIM_PLUGIN_HELPFILES="vimoutliner"
VIM_PLUGIN_MESSAGES="filetype"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '/^if exists/,/endif/d' ftdetect/vo_base.vim
	sed -i -e '/ru .vimoutlinerrc/aru vimoutlinerrc' ftplugin/vo_base.vim
	sed -i -e '/hi spellErr,SpellErrors,BadWord/d' syntax/vo_base.vim
	# weird tarball, bug #83200
	find "${S}" -type f | xargs chmod a+r
}

src_install() {
	p=/usr/share/vim/vimfiles
	for d in doc ftdetect ftplugin syntax ; do
		dodir ${p}/${d}
		cp -R ${d} "${D}"/${p}/
	done

	dodir ${p}/vimoutliner/plugins
	cp -R add-ons/plugins "${D}"/${p}/vimoutliner/

	for d in scripts/* add-ons/scripts/* ; do
		dobin ${d}
	done

	dodoc vimoutlinerrc
}
