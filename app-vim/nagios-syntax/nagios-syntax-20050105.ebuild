# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/nagios-syntax/nagios-syntax-20050105.ebuild,v 1.10 2010/10/07 03:26:29 leio Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: Nagios configuration files syntax"
HOMEPAGE="http://dev.gentoo.org/~ramereth/vim/syntax/nagios.vim"
LICENSE="as-is"
KEYWORDS="alpha amd64 ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for Nagios configuration
files. Detection is by filename (/etc/nagios/)."
