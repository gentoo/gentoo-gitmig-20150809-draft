# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/selinux-syntax/selinux-syntax-20040707.ebuild,v 1.13 2006/11/28 06:48:52 wormo Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: SELinux type enforcement policy syntax"
HOMEPAGE="http://www.cip.ifi.lmu.de/~bleher/selinux/"
LICENSE="vim"
KEYWORDS="alpha amd64 ia64 mips ppc ppc64 sparc x86"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for SELinux type enforcement
policy (*.te) files."
