# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/anthy/anthy-4300b.ebuild,v 1.2 2003/08/24 18:54:26 usata Exp $

IUSE="emacs"

DESCRIPTION="Anthy -- free and secure Japanese input system"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/5332/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
SLOT="0"

S="${WORKDIR}/${P}"

DEPEND="virtual/glibc
	emacs? ( virtual/emacs )"

SITEFILE="50anthy-gentoo.el"
SITELISP=/usr/share/emacs/site-lisp

src_compile() {
	local myconf=""

	use emacs \
		|| myconf="${myconf} EMACS=no"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	if [ -n "` use emacs`" ] ; then
		insinto ${SITELISP}
		doins ${FILESDIR}/${SITEFILE}
	fi

	dodoc AUTHORS ChangeLog DIARY INSTALL NEWS README \
		doc/[A-Z][A-Z]* doc/protocol.txt
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
