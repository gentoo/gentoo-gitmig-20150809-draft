# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/python-mode/python-mode-0.6.3.ebuild,v 1.1 2012/04/27 09:12:00 xarthisius Exp $

EAPI=4

VIM_PLUGIN_MESSAGES="filetype"
VIM_PLUGIN_HELPFILES="PythonModeCommands"
VIM_PLUGIN_HELPURI="https://github.com/klen/python-mode"

inherit vim-plugin

DESCRIPTION="Provide python code looking for bugs, refactoring and other useful things"
HOMEPAGE="http://www.vim.org/scripts/script.php?script_id=3770 https://github.com/klen/python-mode"
SRC_URI="http://www.vim.org/scripts/download_script.php?src_id=17788 -> ${P}.zip"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip"
RDEPEND="
	dev-python/astng
	dev-python/pep8
	dev-python/pyflakes
	dev-python/pylint
	dev-python/rope
	dev-python/ropemode
	"

GIT_REV=9956aba
S=${WORKDIR}/klen-${PN}-${GIT_REV}

src_prepare() {
	rm -rf pylibs/{logilab,pep8.py,pyflakes,pylint,rope,ropemode} .gitignore
	mv pylint.ini "${T}" || die
	sed -e "s|expand(\"<sfile>:p:h:h\")|\"${EPREFIX}/usr/share/${PN}\"|" \
		-i plugin/pymode.vim || die # use custom path
}

src_install() {
	vim-plugin_src_install
	insinto usr/share/${PN}
	doins "${T}"/pylint.ini
}

pkg_postinst() {
	vim-plugin_pkg_postinst
	einfo "If you use custom pylintrc make sure you append the contents of"
	einfo " ${EPREFIX}/usr/share/${PN}/pylint.ini"
	einfo "to it. Otherwise PyLint command will not work properly."
}
