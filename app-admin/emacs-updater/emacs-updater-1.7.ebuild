# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/emacs-updater/emacs-updater-1.7.ebuild,v 1.2 2010/12/12 16:29:01 fauli Exp $

EAPI=2

DESCRIPTION="Rebuild Emacs packages"
HOMEPAGE="http://www.gentoo.org/proj/en/lisp/emacs/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~sparc-fbsd ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND=""
RDEPEND="!<=app-admin/eselect-emacs-1.5
	>=app-portage/portage-utils-0.1.28
	virtual/emacs"

src_prepare() {
	if [ -n "${EPREFIX}" ]; then
		sed -i -e "1s:/:${EPREFIX%/}/:" \
			-e "s:^\(EMACS\|SITELISP\)=:&${EPREFIX%/}:" \
			emacs-updater || die
	fi
}

src_install() {
	dosbin emacs-updater || die "dosbin failed"
	doman emacs-updater.8 || die "doman failed"
}
