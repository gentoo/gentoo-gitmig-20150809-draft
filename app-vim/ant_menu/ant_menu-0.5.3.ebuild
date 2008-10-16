# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/ant_menu/ant_menu-0.5.3.ebuild,v 1.2 2008/10/16 17:06:24 hawking Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: Java ant build system integration"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=155"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc amd64"
IUSE=""
RDEPEND="dev-java/ant"
S=${WORKDIR}/ant-${PV}

VIM_PLUGIN_HELPURI="http://www.vim.org/scripts/script.php?script_id=155"
