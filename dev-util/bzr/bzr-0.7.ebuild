# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bzr/bzr-0.7.ebuild,v 1.3 2006/05/12 22:32:53 flameeyes Exp $

inherit distutils bash-completion elisp-common

MY_P=${P/_rc/rc}

DESCRIPTION="next generation distributed version control"
HOMEPAGE="http://bazaar-ng.org/"
SRC_URI="http://bazaar-ng.org/pkg/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE="emacs"

DEPEND=">=dev-lang/python-2.4
	dev-python/celementtree
	emacs? ( virtual/emacs )
	>=dev-python/paramiko-1.5"

S="${WORKDIR}/${MY_P}"

PYTHON_MODNAME="bzrlib"

src_compile() {
	distutils_src_compile
	if use emacs; then
		elisp-compile contrib/emacs/bzr-mode.el || die "Emacs modules failed!"
	fi
}

src_install() {
	distutils_src_install
	if use emacs; then
		insinto ${SITELISP}
		doins contrib/emacs/bzr-mode.el*
		elisp-site-file-install ${FILESDIR}/70bzr-gentoo.el
	fi
	insinto /usr/share/zsh/site-functions
	doins contrib/zsh/_bzr
	dobashcompletion contrib/bash/bzr
}

pkg_postinst() {
	distutils_pkg_postinst
	use emacs && elisp-site-regen
	bash-completion_pkg_postinst
}

pkg_postrm() {
	distutils_pkg_postrm
	# regenerate site-gentoo if we are merged USE=emacs and unmerged
	# USE=-emacs
	has_version virtual/emacs && elisp-site-regen
}

src_test() {
	"${python}" bzr selftest || die "bzr selftest failed"
}
