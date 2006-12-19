# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mercurial/mercurial-0.9.3.ebuild,v 1.1 2006/12/19 08:44:26 aross Exp $

inherit bash-completion distutils elisp-common flag-o-matic

MY_PV=${PV//_p/.}

DESCRIPTION="scalable distributed SCM"
HOMEPAGE="http://www.selenic.com/mercurial/"
SRC_URI="http://www.selenic.com/mercurial/release/${PN}-${MY_PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ia64 ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="emacs"

RDEPEND=">=dev-lang/python-2.3"
DEPEND="${RDEPEND}
	emacs? ( virtual/emacs )"

PYTHON_MODNAME="${PN} hgext"

src_compile() {
	filter-flags -ftracer -ftree-vectorize

	distutils_src_compile

	if use emacs; then
		cd ${S}/contrib
		elisp-compile mercurial.el || die "Emacs modules failed!"
	fi

	rm -rf contrib/vim	# app-vim/hgcommand app-vim/hgmenu
	rm -rf contrib/{win32,macosx}
}

src_install() {
	distutils_src_install

	dobashcompletion contrib/bash_completion ${PN}

	dodoc CONTRIBUTORS PKG-INFO README *.txt
	cp hgweb*.cgi ${D}/usr/share/doc/${PF}/
	rm -f contrib/bash_completion
	cp -r contrib ${D}/usr/share/doc/${PF}/
	doman doc/*.?

	if use emacs; then
		insinto ${SITELISP}
		doins contrib/mercurial.el*
		elisp-site-file-install ${FILESDIR}/70mercurial-gentoo.el
	fi
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
