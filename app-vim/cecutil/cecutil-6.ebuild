# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/cecutil/cecutil-6.ebuild,v 1.4 2005/03/27 12:13:29 kloeri Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: library used by many of Charles Campbell's plugins"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=1066"
LICENSE="vim"
KEYWORDS="x86 sparc mips ~ppc ~amd64 alpha ~ia64"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides library functions and is not intended to be used
directly by the user. Documentation is available via ':help cecutil.txt'."

src_unpack() {
	unpack ${A}
	cd ${S}
	# automatic help extraction. woohoo! someone please shoot me now...
	mkdir -p ${S}/doc
	sed -n -e '/^\*cecutil.txt\*/,$p' ${S}/plugin/cecutil.vim \
			> ${S}/doc/cecutil.txt \
			|| die "sed 1 failed. not good."
	sed -i -e '/^" HelpExtractor:/,$d' ${S}/plugin/cecutil.vim \
			|| die "sed 2 failed. not good."
}
