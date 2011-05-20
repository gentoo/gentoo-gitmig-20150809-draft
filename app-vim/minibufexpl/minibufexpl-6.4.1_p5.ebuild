# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/minibufexpl/minibufexpl-6.4.1_p5.ebuild,v 1.1 2011/05/20 07:39:50 radhermit Exp $

EAPI=4

inherit vim-plugin

DESCRIPTION="vim plugin: easily switch between buffers"
HOMEPAGE="https://github.com/fholgado/minibufexpl.vim"
SRC_URI="https://github.com/fholgado/${PN}.vim/tarball/${PV/_p/b} -> ${P}.tar.gz"

LICENSE="as-is"
KEYWORDS="~alpha ~amd64 ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="minibufexpl.txt"

src_unpack() {
	unpack ${A}
	mv fholgado-minibufexpl.vim-* "${S}"
}

src_prepare() {
	# There's good documentation included with the script, but it's not
	# in a helpfile. Since there's rather too much information to include
	# in a VIM_PLUGIN_HELPTEXT, we'll sed ourselves a help doc.
	mkdir "${S}"/doc
	sed -e '1,/"=\+$/d' -e '/"=\+$/,9999d' -e 's/^" \?//' \
		-e 's/\(Name Of File: \)\([^.]\+\)\.vim/\1*\2.txt*/' \
		plugin/minibufexpl.vim \
		> doc/minibufexpl.txt
}
