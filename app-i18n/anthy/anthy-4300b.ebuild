# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/anthy/anthy-4300b.ebuild,v 1.3 2003/09/04 19:15:04 usata Exp $

inherit elisp

IUSE="emacs"

DESCRIPTION="Anthy -- free and secure Japanese input system"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/5332/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"
SLOT="0"

S="${WORKDIR}/${P}"

E_DEPEND="emacs? ( ${E_DEPEND} )"
E_RDEPEND="emacs? ( ${E_DEPEND} )"
DEPEND="virtual/glibc"

if [ -n "`use emacs`" ] ; then
	SITEFILE="50anthy-gentoo.el"
else
	pkg_postinst () {
		einfo "Emacs support is disabled."
	}
	pkg_postrm () {
		einfo "Emacs support is disabled."
	}
fi

src_compile() {

	econf `use emacs >/dev/null 2>&1 || echo EMACS=no` || die
	emake || die
}

src_install() {

	einstall || die

	use emacs && elisp-site-file-install ${FILESDIR}/${SITEFILE}

	dodoc AUTHORS ChangeLog DIARY INSTALL NEWS README \
		doc/[A-Z][A-Z]* doc/protocol.txt
}
