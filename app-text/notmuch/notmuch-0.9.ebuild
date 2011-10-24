# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/notmuch/notmuch-0.9.ebuild,v 1.2 2011/10/24 12:17:18 aidecoe Exp $

EAPI=4

inherit autotools-utils elisp-common

DESCRIPTION="The mail indexer"
HOMEPAGE="http://notmuchmail.org/"
SRC_URI="${HOMEPAGE}/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="bash-completion debug emacs vim zsh-completion"

DEPEND="
	>=dev-libs/glib-2.14
	dev-libs/gmime:2.4
	dev-libs/xapian
	sys-libs/talloc
	debug? ( dev-util/valgrind )
	emacs? ( >=virtual/emacs-23 )
	vim? ( || ( >=app-editors/vim-7.0 >=app-editors/gvim-7.0 ) )
	"
RDEPEND="${DEPEND}
	zsh-completion? ( app-shells/zsh )
	"

DOCS=( AUTHORS NEWS README TODO )
PATCHES=( "${FILESDIR}/${PV}-fix-lib-makefile-local.patch" )

pkg_setup() {
	if use emacs; then
		elisp-need-emacs 23 || die "Emacs version too low"
	fi
}

src_configure() {
	local myeconfargs=(
		--bashcompletiondir="${ROOT}/usr/share/bash-completion"
		--emacslispdir="${ROOT}/usr/share/emacs/site-lisp/${PN}"
		--zshcompletiondir="${ROOT}/usr/share/zsh/site-functions"
		$(use_with bash-completion)
		$(use_with emacs)
		$(use_with zsh-completion)
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install

	if use vim; then
		insinto /usr/share/vim/vimfiles
		doins -r vim/plugin vim/syntax
	fi
}
