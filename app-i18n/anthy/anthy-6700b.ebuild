# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/anthy/anthy-6700b.ebuild,v 1.8 2006/04/22 14:38:02 hattya Exp $

inherit elisp-common eutils

IUSE="emacs ucs4"

DESCRIPTION="Anthy -- free and secure Japanese input system"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/15414/${P}.tar.gz"

RESTRICT="nomirror"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ia64 ppc ~ppc-macos ppc64 sparc x86"
SLOT="0"

DEPEND="emacs? ( virtual/emacs )
	!app-i18n/anthy-ss"

src_unpack() {

	unpack ${A}

	cd ${S}
	if has_version '>=sys-devel/gcc-3.4' ; then
		epatch ${FILESDIR}/anthy-mkdic-gcc34.patch
	fi
}

src_compile() {

	local myconf
	local cannadicdir=/var/lib/canna/dic/canna

	use emacs || myconf="EMACS=no"
	use ucs4 && myconf="${myconf} --enable-ucs4"

	if has_version 'app-dicts/canna-zipcode'; then
		einfo "Adding zipcode.t and jigyosyo.t to anthy.dic."
		cp ${cannadicdir}/{zipcode,jigyosyo}.t mkanthydic
		sed -i -e "/^EXTRA_DICS/s|$| zipcode.t jigyosyo.t|" mkanthydic/Makefile.in
	fi

	if has_version 'app-dicts/canna-2ch'; then
		einfo "Adding nichan.ctd to anthy.dic."
		cp ${cannadicdir}/nichan.ctd mkanthydic/2ch.t
		sed -i -e "/^EXTRA_DICS/s|$| 2ch.t|" mkanthydic/Makefile.in
	fi

	econf ${myconf} || die
	emake -j1 || die

}

src_install() {

	make DESTDIR=${D} install || die

	use emacs && elisp-site-file-install ${FILESDIR}/50anthy-gentoo.el

	dodoc [A-Z][A-Z]* ChangeLog doc/[A-Z0-9][A-Z0-9]* doc/protocol.txt

}

pkg_postinst() {

	use emacs && elisp-site-regen

}

pkg_postrm() {

	has_version virtual/emacs && elisp-site-regen

}
