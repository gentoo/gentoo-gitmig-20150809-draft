# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/anthy/anthy-4507.ebuild,v 1.1 2003/09/11 07:41:05 usata Exp $

IUSE="emacs"

DESCRIPTION="Anthy -- free and secure Japanese input system"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/5847/${P}.tar.gz"

# This branch, so-called anthy-ss (snapshot) is a development branch,
# so it is not intended to be marked as stable.  It will remain unstable
# all the time unless there comes another -ss branch.
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="0"

S="${WORKDIR}/${P}"

DEPEND="virtual/glibc
	emacs? ( virtual/emacs )
	app-dicts/canna-cannadic"
RDEPEND="virtual/glibc
	emacs? ( virtual/emacs )"

SITEFILE="50anthy-gentoo.el"
SITELISP=/usr/share/emacs/site-lisp

src_compile() {

	local myconf cannadicdir
	cannadicdir=/var/lib/canna/dic/canna

	use emacs \
		|| myconf="${myconf} EMACS=no"

	if has_version 'app-dicts/canna-zipcode' ; then
		einfo "Adding zipcode.t and jigyosyo.t to anthy.dic."
		cp ${cannadicdir}/{zipcode,jigyosyo}.t mkanthydic
		sed -i -e "/^EXTRA_DICS/s|$| zipcode.t jigyosyo.t|" \
			mkanthydic/Makefile.{in,am}
	fi
	if has_version 'app-dicts/canna-2ch' ; then
		einfo "Adding nichan.ctd to anthy.dic."
		cp ${cannadicdir}/nichan.ctd mkanthydic/2ch.t
		sed -i -e "/^EXTRA_DICS/s|$| 2ch.t|" \
			mkanthydic/Makefile.{in,am}
	fi

	econf ${myconf} --with-cannadic=${cannadicdir} || die
	emake || die
}

src_install() {
	einstall || die

	if [ -n "` use emacs`" ] ; then
		insinto ${SITELISP}
		doins ${FILESDIR}/${SITEFILE}
	fi

	dodoc AUTHORS ChangeLog DIARY INSTALL NEWS README \
		doc/[A-Z0-9][A-Z0-9]* doc/protocol.txt
}

pkg_postinst() {

	if [ -n "` use emacs`" ] ; then
		inherit elisp
		elisp-site-regen
	fi
}

pkg_postrm() {

	if [ -n "` use emacs`" ] ; then
		inherit elisp
		elisp-site-regen
	fi
}
