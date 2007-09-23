# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skktools/skktools-1.3.ebuild,v 1.2 2007/09/23 06:04:55 mr_bones_ Exp $

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

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-gentoo.patch"
}

src_compile() {
	econf $(use_with gdbm) || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dobin saihenkan.rb
	use emacs && elisp-site-file-install skk-xml.el

	insinto /usr/share/skk
	doins unannotation.awk

	dodoc ChangeLog README READMEs/*
}
