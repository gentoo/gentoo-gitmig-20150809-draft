# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/nagios-syntax/nagios-syntax-20050105.ebuild,v 1.6 2005/04/06 18:23:44 corsair Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: Nagios configuration files syntax"
HOMEPAGE="http://dev.gentoo.org/~ramereth/vim/syntax/nagios.vim"
LICENSE="as-is"
KEYWORDS="x86 sparc mips ppc64 ~amd64 alpha ia64"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for Nagios configuration
files. Detection is by filename (/etc/nagios/)."
