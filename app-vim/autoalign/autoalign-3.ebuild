# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/autoalign/autoalign-3.ebuild,v 1.1 2004/08/21 19:06:14 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: automatically align bib, c, tex and vim code"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=884"
LICENSE="vim"
KEYWORDS="~x86 ~sparc ~mips"
IUSE=""

RDEPEND=">=app-vim/align-28"

src_unpack() {
	unpack ${A}
	cd ${S}
	# Have contacted upstream about this bug, no reply yet. I'm not
	# sure why the l is in there, but it causes an annoying beep each
	# time vim tries to go beyond eol... Please drop me (ciaranm)
	# an email if you can explain why there's an 'l' after a '$'...
	find . -name '*.vim' -exec sed -i -e \
		's~norm \\t=\$l~norm \\t=$~g' '{}' \;
}

