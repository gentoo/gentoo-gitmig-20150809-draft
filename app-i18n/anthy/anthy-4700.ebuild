# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/anthy/anthy-4700.ebuild,v 1.5 2004/06/28 01:40:27 vapier Exp $

inherit elisp-common

DESCRIPTION="free and secure Japanese input system"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/6621/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc alpha"
IUSE="emacs"

DEPEND="virtual/libc
	!app-i18n/anthy-ss
	emacs? ( virtual/emacs )"

SITEFILE="50anthy-gentoo.el"

src_compile() {
	local myconf=""
	use emacs || myconf="EMACS=no"
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	use emacs && elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc AUTHORS ChangeLog DIARY INSTALL NEWS README \
		doc/[A-Z][A-Z]* doc/protocol.txt
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
