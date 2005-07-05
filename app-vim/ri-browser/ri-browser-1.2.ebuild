# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/ri-browser/ri-browser-1.2.ebuild,v 1.3 2005/07/05 10:15:16 slarti Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: interface for browsing ri/ruby documentation."
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=494"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~sparc"
IUSE=""

RDEPEND="dev-lang/ruby"

VIM_PLUGIN_HELPFILES="ri.txt"
VIM_PLUGIN_MESSAGES="filetype"
