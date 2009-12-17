# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/ant_menu/ant_menu-0.5.3.ebuild,v 1.3 2009/12/17 10:19:26 fauli Exp $

inherit vim-plugin

DESCRIPTION="vim plugin: Java ant build system integration"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=155"
LICENSE="LGPL-2"
KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~x86-macos"
IUSE=""
RDEPEND="dev-java/ant"
S=${WORKDIR}/ant-${PV}

VIM_PLUGIN_HELPURI="http://www.vim.org/scripts/script.php?script_id=155"
