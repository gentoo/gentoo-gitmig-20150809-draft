# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/howm/howm-1.3.3.ebuild,v 1.2 2006/12/03 23:52:32 opfer Exp $

inherit elisp

DESCRIPTION="note-taking tool on Emacs"
HOMEPAGE="http://howm.sourceforge.jp/"
SRC_URI="http://howm.sourceforge.jp/a/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
IUSE="linguas_ja"

SITEFILE="55howm-gentoo.el"

src_compile() {
	if use linguas_ja ; then
		cat >>${T}/${SITEFILE}<<-EOF
		(setq howm-menu-lang 'ja)	; Japanese interface"
		EOF
	fi

	econf --with-docdir=/usr/share/doc/${P} || die
	emake < /dev/null || die
}

src_install() {
	emake < /dev/null \
		DESTDIR=${D} PREFIX=/usr LISPDIR=${SITELISP}/${PN} install || die
	dodoc NEWS README AUTHORS ChangeLog
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}