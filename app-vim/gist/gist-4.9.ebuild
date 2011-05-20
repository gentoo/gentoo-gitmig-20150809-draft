# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/gist/gist-4.9.ebuild,v 1.1 2011/05/20 08:10:15 radhermit Exp $

EAPI=4

inherit vim-plugin

DESCRIPTION="vim plugin: interact with gists (gist.github.com)"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2423"
LICENSE="BSD"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="net-misc/curl
	dev-vcs/git"

VIM_PLUGIN_HELPFILES="gist.txt"

src_prepare() {
	# There's good documentation included with the script, but it's not
	# in a helpfile. Since there's rather too much information to include
	# in a VIM_PLUGIN_HELPTEXT, we'll sed ourselves a help doc.
	mkdir "${S}"/doc
	sed -e '0,/"=\+$/d' -e '/" GetLatest.\+$/,9999d' -e 's/^" \?//' \
		-e 's/\(File: \)\([^.]\+\)\.vim/\1*\2.txt*/' \
		plugin/gist.vim \
		> doc/gist.txt
}
