# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/anthy-ss/anthy-ss-8011.ebuild,v 1.1 2006/08/12 09:08:06 hattya Exp $

inherit elisp-common eutils

IUSE="emacs ucs4"

MY_P=${P/-ss/}

DESCRIPTION="Anthy -- free and secure Japanese input system"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/21330/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
SLOT="0"
S=${WORKDIR}/${MY_P}

DEPEND="!app-i18n/anthy
	emacs? ( virtual/emacs )"

src_unpack() {

	unpack ${A}
	cd "${S}"

	local cannadicdir=/var/lib/canna/dic/canna

	if has_version 'app-dicts/canna-2ch'; then
		einfo "Adding nichan.ctd to anthy.dic."
		sed -i /placename/a"read ${cannadicdir}/nichan.ctd" \
			mkworddic/dict.args.in
	fi

}

src_compile() {

	local myconf

	use emacs || myconf="EMACS=no"
	use ucs4 && myconf="${myconf} --enable-ucs4"

	econf ${myconf} || die
	emake -j1 || die

}

src_install() {

	emake DESTDIR="${D}" install || die

	use emacs && elisp-site-file-install "${FILESDIR}"/50anthy-gentoo.el

	dodoc AUTHORS DIARY NEWS README ChangeLog

	docinto doc
	rm doc/Makefile*
	dodoc doc/*

}

pkg_postinst() {

	use emacs && elisp-site-regen

}

pkg_postrm() {

	has_version virtual/emacs && elisp-site-regen

}
