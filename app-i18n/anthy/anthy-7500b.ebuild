# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/anthy/anthy-7500b.ebuild,v 1.1 2006/04/22 14:35:23 hattya Exp $

inherit elisp-common eutils

IUSE="emacs ucs4"

DESCRIPTION="Anthy -- free and secure Japanese input system"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/19902/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc-macos ~ppc64 ~sparc ~x86"
SLOT="0"

DEPEND="emacs? ( virtual/emacs )
	!app-i18n/anthy-ss"

src_compile() {

	local myconf
	local cannadicdir=/var/lib/canna/dic/canna

	use emacs || myconf="EMACS=no"
	use ucs4 && myconf="${myconf} --enable-ucs4"

	if has_version 'app-dicts/canna-2ch'; then
		einfo "Adding nichan.ctd to anthy.dic."
		sed -i -e /placename/a"read ${cannadicdir}/nichan.ctd" \
			mkworddic/dict.args.in
	fi

	econf ${myconf} || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	use emacs && elisp-site-file-install ${FILESDIR}/50anthy-gentoo.el

	rm doc/Makefile*

	dodoc AUTHORS DIARY NEWS README ChangeLog
	dodoc doc/*

}

pkg_postinst() {

	use emacs && elisp-site-regen

}

pkg_postrm() {

	has_version virtual/emacs && elisp-site-regen

}
