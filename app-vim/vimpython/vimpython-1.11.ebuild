# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vimpython/vimpython-1.11.ebuild,v 1.1 2007/05/08 16:13:42 pioto Exp $

VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: A set of menus/shortcuts to work with Python files"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=30"

LICENSE="vim"
KEYWORDS="~x86"
IUSE=""

RDEPEND="${DEPEND}"

VIM_PLUGIN_HELPURI="${HOMEPAGE}"
