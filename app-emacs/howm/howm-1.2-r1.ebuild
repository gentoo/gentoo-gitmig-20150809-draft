# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/howm/howm-1.2-r1.ebuild,v 1.4 2007/07/06 18:37:09 ulm Exp $

inherit elisp

DESCRIPTION="note-taking tool on Emacs"
HOMEPAGE="http://howm.sourceforge.jp/"
SRC_URI="http://howm.sourceforge.jp/a/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

SITEFILE="55howm-gentoo.el"

src_compile() {
	cp ${FILESDIR}/${SITEFILE} ${T}
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
	elisp-site-file-install ${T}/${SITEFILE} || die
}
