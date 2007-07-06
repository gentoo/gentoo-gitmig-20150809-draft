# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/howm/howm-1.3.4.ebuild,v 1.1 2007/07/06 18:37:09 ulm Exp $

inherit elisp

DESCRIPTION="note-taking tool on Emacs"
HOMEPAGE="http://howm.sourceforge.jp/"
SRC_URI="http://howm.sourceforge.jp/a/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="linguas_ja"

SITEFILE="55howm-gentoo.el"

src_compile() {
	if use linguas_ja ; then
		cat >>"${T}/${SITEFILE}"<<-EOF
		(setq howm-menu-lang 'ja)	; Japanese interface"
		EOF
	fi

	econf --with-docdir=/usr/share/doc/${P} || die "econf failed"
	emake < /dev/null || die "emake failed"
}

src_install() {
	emake < /dev/null \
		DESTDIR="${D}" PREFIX=/usr LISPDIR="${SITELISP}/${PN}" install \
		|| die "emake install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc ChangeLog || die "dodoc failed"
}
