# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skktools/skktools-1.3.1-r1.ebuild,v 1.1 2007/10/07 16:28:25 matsuu Exp $

inherit elisp-common eutils

DESCRIPTION="SKK utilities to manage dictionaries"
HOMEPAGE="http://openlab.jp/skk/"
SRC_URI="http://openlab.ring.gr.jp/skk/tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="emacs gdbm"

DEPEND="emacs? ( virtual/emacs )
	gdbm? ( sys-libs/gdbm )
	!gdbm? ( sys-libs/db )
	>=dev-libs/glib-2"

SITEFILE=50${PN}-gentoo.el

src_compile() {
	econf $(use_with gdbm) || die
	emake || die
	if use emacs; then
		elisp-compile skk-xml.el || die
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die

	dobin saihenkan.rb
	if use emacs; then
		elisp-install ${PN} skk-xml.{el,elc} || die
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	fi

	insinto /usr/share/skk
	doins unannotation.awk

	dodoc ChangeLog README READMEs/*
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrmt() {
	use emacs && elisp-site-regen
}
