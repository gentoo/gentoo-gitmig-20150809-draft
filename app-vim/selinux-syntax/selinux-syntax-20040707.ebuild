# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/selinux-syntax/selinux-syntax-20040707.ebuild,v 1.8 2005/02/18 20:51:13 slarti Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: SELinux type enforcement policy syntax"
HOMEPAGE="http://www.cip.ifi.lmu.de/~bleher/selinux/"
LICENSE="vim"
KEYWORDS="x86 sparc mips ~ppc64 ~amd64"
IUSE=""

VIM_PLUGIN_HELPTEXT=\
"This plugin provides syntax highlighting for SELinux type enforcement
policy (*.te) files."
