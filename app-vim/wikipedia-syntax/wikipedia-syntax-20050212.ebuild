# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/wikipedia-syntax/wikipedia-syntax-20050212.ebuild,v 1.6 2005/04/01 03:54:31 agriffis Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: Wikipedia syntax highlighting"
HOMEPAGE="http://en.wikipedia.org/wiki/Wikipedia:Text_editor_support#Vim"
LICENSE="as-is"
KEYWORDS="x86 sparc mips ~hppa ~arm ~ppc64 ~amd64 ~alpha ia64"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for Wikipedia article
files. Detection is by filename (*.wiki)."
VIM_PLUGIN_MESSAGES="filetype"

