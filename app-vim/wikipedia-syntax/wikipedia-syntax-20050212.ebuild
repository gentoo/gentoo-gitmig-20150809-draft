# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/wikipedia-syntax/wikipedia-syntax-20050212.ebuild,v 1.10 2006/01/21 14:56:08 pylon Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: Wikipedia syntax highlighting"
HOMEPAGE="http://en.wikipedia.org/wiki/Wikipedia:Text_editor_support#Vim"
LICENSE="as-is"
KEYWORDS="alpha ~amd64 ~arm ~hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for Wikipedia article
files. Detection is by filename (*.wiki)."
VIM_PLUGIN_MESSAGES="filetype"

