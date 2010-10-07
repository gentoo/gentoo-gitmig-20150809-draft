# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/minibufexpl/minibufexpl-6.3.1-r1.ebuild,v 1.7 2010/10/07 03:23:15 leio Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: easily switch between buffers"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=159"

LICENSE="as-is"
KEYWORDS="alpha amd64 ia64 ~mips ~ppc sparc x86"
IUSE=""

VIM_PLUGIN_HELPFILES="minibufexpl.txt"

src_unpack() {
	unpack ${A}
	cd ${S}
	# There's good documentation included with the script, but it's not
	# in a helpfile. Since there's rather too much information to include
	# in a VIM_PLUGIN_HELPTEXT, we'll sed ourselves a help doc.
	mkdir ${S}/doc
	sed -e '1,/"=\+$/d' -e '/"=\+$/,9999d' -e 's/^" \?//' \
		-e 's/\(Name Of File: \)\([^.]\+\)\.vim/\1*\2.txt*/' \
		plugin/minibufexpl.vim \
		> doc/minibufexpl.txt
}
