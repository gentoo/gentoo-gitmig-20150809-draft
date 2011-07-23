# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/colorschemes/colorschemes-20110506.ebuild,v 1.4 2011/07/23 17:21:25 armin76 Exp $

EAPI="4"

inherit vim-plugin eutils

DESCRIPTION="vim plugin: a collection of color schemes from vim.org"
HOMEPAGE="http://www.vim.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="vim GPL-2 public-domain as-is"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ~ppc ~ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides a collection of color schemes for vim. To switch
color schemes, use :colorscheme schemename (tab completion is available
for scheme names). To automatically set a scheme at startup, please see
:help vimrc."

src_prepare() {
	EPATCH_SOURCE="${S}/patches" \
	EPATCH_SUFFIX="patch" \
	EPATCH_FORCE="yes" \
	epatch
	rm -rf patches/
}
