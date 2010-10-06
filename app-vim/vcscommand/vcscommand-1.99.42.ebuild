# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/vcscommand/vcscommand-1.99.42.ebuild,v 1.2 2010/10/06 15:36:31 jer Exp $

EAPI=3

VIM_PLUGIN_VIM_VERSION="7.0"
inherit vim-plugin

DESCRIPTION="vim plugin: CVS/SVN/SVK/git/bzr/hg integration plugin"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=90"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=13751 -> ${P}.zip"

LICENSE="public-domain"
KEYWORDS="~amd64 ~hppa ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND="!app-vim/cvscommand"
DEPEND="app-arch/unzip"

VIM_PLUGIN_HELPFILES="vcscommand"

S="${WORKDIR}"
