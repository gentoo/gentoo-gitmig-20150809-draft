# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/project/project-1.4.1.ebuild,v 1.1 2009/04/16 01:11:42 volkmar Exp $

EAPI="2"

inherit vim-plugin

DESCRIPTION="vim plugin: Managing multiple projects with multiple sources like
an IDE"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=69"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=6273
	-> ${P}.tar.gz"

LICENSE="as-is"
KEYWORDS="~ppc"
IUSE=""

S=${WORKDIR}

VIM_PLUGIN_HELPFILES="project"
