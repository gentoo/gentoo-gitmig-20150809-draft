# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-cpp/ctemplate/ctemplate-0.98.ebuild,v 1.1 2010/10/26 07:41:45 radhermit Exp $

EAPI="3"

inherit elisp-common

DESCRIPTION="A simple but powerful template language for C++"
HOMEPAGE="http://code.google.com/p/google-ctemplate/"
SRC_URI="http://google-ctemplate.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="doc emacs vim-syntax"

DEPEND=""
RDEPEND="vim-syntax? ( >=app-editors/vim-core-7 )
	emacs? ( virtual/emacs )"

SITEFILE="70ctemplate-gentoo.el"

src_compile() {
	emake || die "emake failed"

	if use emacs ; then
		elisp-compile contrib/tpl-mode.el || die "elisp-compile failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# Installs just every piece
	rm -rf "${ED}/usr/share/doc"

	dodoc AUTHORS ChangeLog NEWS README
	use doc && dohtml doc/*

	if use vim-syntax ; then
		cd "${S}/contrib"
		sh highlighting.vim || die "unpacking vim scripts failed"
		insinto /usr/share/vim/vimfiles
		doins -r .vim/*
	fi

	if use emacs ; then
		cd "${S}/contrib"
		elisp-install ${PN} tpl-mode.el tpl-mode.elc || die "elisp-install failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
