# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vimirc/vimirc-0.8.5-r1.ebuild,v 1.1 2004/09/06 22:20:13 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: IRC Client"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=931"
LICENSE="vim"
KEYWORDS="~x86 sparc mips ~ppc"
IUSE=""

VIM_PLUGIN_HELPFILES="vimirc.txt"

# requires 6.2.412 at runtime. it's not too keen upon console vim, so we'll
# just ask for gvim.
RDEPEND=">=app-editors/gvim-6.2-r8"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Documentation is supplied in the source file.
	mkdir doc
	sed -e '/^[^"]/,9999d' -e 's~^" \?~~' -e '1s/$/ *vimirc.txt*/' \
		plugin/vimirc.vim > doc/vimirc.txt
}

pkg_postinst() {
	vim-plugin_pkg_postinst
	einfo " "
	einfo "This plugin requires a Vim with perl support enabled. This is"
	einfo "controlled by the 'perl' USE flag."
	einfo " "
}
