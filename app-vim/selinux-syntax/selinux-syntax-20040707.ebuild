# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/selinux-syntax/selinux-syntax-20040707.ebuild,v 1.5 2004/09/05 01:33:06 ciaranm Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: SELinux type enforcement policy syntax"
HOMEPAGE="http://www.cip.ifi.lmu.de/~bleher/selinux/"
LICENSE="vim"
KEYWORDS="x86 sparc mips"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for SELinux type enforcement
policy (*.te) files."
