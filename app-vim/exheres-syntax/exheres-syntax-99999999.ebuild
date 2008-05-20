# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/exheres-syntax/exheres-syntax-99999999.ebuild,v 1.1 2008/05/20 00:08:07 coldwind Exp $

inherit vim-plugin subversion

DESCRIPTION="vim plugin: exheres format highlighting"
HOMEPAGE="http://www.exherbo.org/"
SRC_URI=""
ESVN_REPO_URI="http://svn.exherbo.org/exheres-syntax/trunk"

LICENSE="vim"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="exheres-syntax"
VIM_PLUGIN_MESSAGES="filetype"
