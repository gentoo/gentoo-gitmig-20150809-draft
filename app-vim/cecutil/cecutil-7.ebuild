# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/cecutil/cecutil-7.ebuild,v 1.8 2010/10/07 02:58:46 leio Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: library used by many of Charles Campbell's plugins"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1066"
LICENSE="vim"
KEYWORDS="alpha amd64 ia64 ~mips ppc sparc x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides library functions and is not intended to be used
directly by the user. Documentation is available via ':help cecutil.txt'."

src_unpack() {
	unpack ${A}
	cd "${S}"
	# automatic help extraction. woohoo! someone please shoot me now...
	mkdir -p "${S}"/doc
	sed -n -e '/^\*cecutil.txt\*/,$p' "${S}"/plugin/cecutil.vim \
			> "${S}"/doc/cecutil.txt \
			|| die "sed 1 failed. not good."
	sed -i -e '/^" HelpExtractor:/,$d' "${S}"/plugin/cecutil.vim \
			|| die "sed 2 failed. not good."
}
