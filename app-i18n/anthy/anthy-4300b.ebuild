# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/anthy/anthy-4300b.ebuild,v 1.1 2003/08/20 14:02:45 usata Exp $

inherit elisp

DESCRIPTION="Anthy -- free and secure Japanese input system"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/5332/${P}.tar.gz"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
SLOT="0"
IUSE="emacs"

S="${WORKDIR}/${P}"

DEPEND="virtual/glibc
	emacs? ( virtual/emacs )"

SITEFILE="50anthy-gentoo.el"

src_compile() {
	local myconf=""

	use emacs \
		|| myconf="${myconf} EMACS=no"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	use emacs && elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc AUTHORS ChangeLog DIARY INSTALL NEWS README \
		doc/{DICUTIL,ELISP,GLOSSARY,GUIDE.english,ILIB,LERNING,LIB} \
		doc/{MISC,POS,SPLITTER,TESTING,protocol.txt}
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
