# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bzr/bzr-0.10.ebuild,v 1.1 2006/09/04 15:47:01 marienz Exp $

inherit distutils bash-completion elisp-common eutils

DESCRIPTION="next generation distributed version control"
HOMEPAGE="http://bazaar-vcs.org/"
SRC_URI="http://bazaar-vcs.org/releases/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86 ~x86-fbsd"
IUSE="emacs"

DEPEND=">=dev-lang/python-2.4
	dev-python/celementtree
	emacs? ( virtual/emacs )
	>=dev-python/paramiko-1.5"

PYTHON_MODNAME="bzrlib"

DOCS="HACKING NEWS NEWS.developers"


src_unpack() {
	unpack ${A}
	cd "${S}"

	# Install the manpage in /usr/share/man instead of /usr/man
	epatch "${FILESDIR}/${P}-fix-manpage-location.patch"
}

src_compile() {
	distutils_src_compile
	if use emacs; then
		elisp-compile contrib/emacs/bzr-mode.el || die "Emacs modules failed!"
	fi
}

src_install() {
	distutils_src_install
	if use emacs; then
		insinto "${SITELISP}"
		doins contrib/emacs/bzr-mode.el*
		elisp-site-file-install "${FILESDIR}/70bzr-gentoo.el"
	fi
	insinto /usr/share/zsh/site-functions
	doins contrib/zsh/_bzr
	dobashcompletion contrib/bash/bzr
}

pkg_postinst() {
	distutils_pkg_postinst
	use emacs && elisp-site-regen
	bash-completion_pkg_postinst

	einfo "If you just upgraded from a version of bzr older than 0.9"
	einfo "you should rename your ~/.bazaar/branches.conf to locations.conf"
	einfo "(see /usr/share/doc/${PF}/NEWS.gz)"
}

pkg_postrm() {
	distutils_pkg_postrm
	# regenerate site-gentoo if we are merged USE=emacs and unmerged
	# USE=-emacs
	has_version virtual/emacs && elisp-site-regen
}

src_test() {
	"${python}" bzr --no-plugins selftest || die "bzr selftest failed"
}
