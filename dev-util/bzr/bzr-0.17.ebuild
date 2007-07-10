# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bzr/bzr-0.17.ebuild,v 1.2 2007/07/10 23:25:11 jokey Exp $

inherit distutils bash-completion elisp-common eutils

MY_P=${P/_rc/rc}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Bazaar is a next generation distributed version control system."
HOMEPAGE="http://bazaar-vcs.org/"
SRC_URI="http://bazaar-vcs.org/releases/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="curl emacs test"

python_rdep="dev-python/celementtree
	>=dev-python/paramiko-1.5
	curl? ( dev-python/pycurl )"
DEPEND=">=dev-lang/python-2.4
	emacs? ( virtual/emacs )
	test? (
		$python_rdep
		dev-python/medusa
	)"
RDEPEND=">=dev-lang/python-2.4
	$python_rdep"

PYTHON_MODNAME="bzrlib"

DOCS="doc/*.txt"

# disable until bug #173301 is solved
RESTRICT="test"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Install the manpage in /usr/share/man instead of /usr/man
	epatch "${FILESDIR}/${PN}-0.16-fix-manpage-location.patch"
}

src_compile() {
	distutils_src_compile
	if use emacs; then
		elisp-compile contrib/emacs/bzr-mode.el || die "Emacs modules failed!"
	fi
}

src_install() {
	distutils_src_install
	docinto developers
	dodoc doc/developers/*
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
}

pkg_postrm() {
	distutils_pkg_postrm
	use emacs && elisp-site-regen
}

src_test() {
	"${python}" bzr --no-plugins selftest || die "bzr selftest failed"
}
