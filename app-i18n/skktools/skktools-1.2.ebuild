# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skktools/skktools-1.2.ebuild,v 1.1 2006/11/07 06:04:16 usata Exp $

inherit elisp-common

DESCRIPTION="SKK utilities to manage dictionaries"
HOMEPAGE="http://openlab.jp/skk/"
SRC_URI="http://openlab.ring.gr.jp/skk/tools/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="ruby emacs"

DEPEND="virtual/libc
	>=dev-libs/glib-2"

src_install() {
	make DESTDIR=${D} install || die

	use ruby && dobin saihenkan.rb
	use emacs && elisp-site-file-install skk-xml.el

	insinto /usr/share/skk
	doins unannotation.awk

	dodoc ChangeLog README READMEs/*
}
