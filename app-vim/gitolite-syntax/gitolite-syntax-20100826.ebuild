# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/gitolite-syntax/gitolite-syntax-20100826.ebuild,v 1.3 2011/02/12 09:50:55 hwoarang Exp $

EAPI=3

inherit vim-plugin

DESCRIPTION="vim plugin: gitolite syntax highlighting"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2900"
LICENSE="Apache-2.0"
KEYWORDS="amd64 x86"
IUSE=""

S=$WORKDIR
SRC_URI="mirror://gentoo/${P}.tar.bz2"
VIM_PLUGIN_HELPTEXT="Vim Syntax highlight for gitolite configuration file gitolite.conf"
