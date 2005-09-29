# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/cfengine-syntax/cfengine-syntax-20050105.ebuild,v 1.9 2005/09/29 21:08:15 metalgod Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: Cfengine configuration files syntax"
HOMEPAGE="http://dev.gentoo.org/~ramereth/vim/syntax/cfengine.vim"
LICENSE="as-is"
KEYWORDS="alpha amd64 ia64 mips ppc ppc64 sparc x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for Cfengine configuration
files. Detection is by filename (/var/cfengine/inputs/)."
