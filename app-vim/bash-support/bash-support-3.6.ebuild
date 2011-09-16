# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/bash-support/bash-support-3.6.ebuild,v 1.1 2011/09/16 21:18:48 radhermit Exp $

EAPI=4

inherit vim-plugin

DESCRIPTION="vim plugin: Bash-IDE - Write and run bash scripts using menus and hotkeys"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=365"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=16019 -> ${P}.zip"
LICENSE="public-domain"
KEYWORDS="~amd64 ~x86"
IUSE=""

VIM_PLUGIN_HELPFILES="${PN}.txt"

DEPEND="app-arch/unzip"

S="${WORKDIR}"

src_install() {
	dodoc ${PN}/doc/{ChangeLog,bash-hot-keys.pdf}
	rm -rf ${PN}/doc

	vim-plugin_src_install
}
