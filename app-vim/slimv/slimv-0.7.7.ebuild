# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/slimv/slimv-0.7.7.ebuild,v 1.1 2011/03/22 09:38:33 radhermit Exp $

EAPI=3

inherit vim-plugin

DESCRIPTION="vim plugin: aid Lisp development by providing a SLIME-like Lisp and Clojure REPL"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=2531"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=15122 -> ${P}.zip"
LICENSE="public-domain"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND=">=dev-lang/python-2.4
	|| ( dev-lisp/clisp dev-lang/clojure )"

VIM_PLUGIN_HELPFILES="slimv.txt"

S=${WORKDIR}
