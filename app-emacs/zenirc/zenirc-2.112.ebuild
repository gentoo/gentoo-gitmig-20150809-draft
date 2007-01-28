# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/zenirc/zenirc-2.112.ebuild,v 1.7 2007/01/28 04:41:25 genone Exp $

inherit elisp

DESCRIPTION="ZenIRC is a full-featured scriptable IRC client for the EMACS text editor."
HOMEPAGE="http://www.zenirc.org"
SRC_URI="ftp://ftp.zenirc.org/pub/zenirc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/emacs"

SITEFILE=50zenirc-gentoo.el

src_compile() {
	./configure --prefix=/usr || die
	make || die
}

src_install() {
	make prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		elispdir=${D}/${SITELISP}/${PN} \
		etcdir=${D}/usr/share/${PN}  install || die

	elisp-install ${PN} src/*.el || die
	elisp-site-file-install ${FILESDIR}/${SITEFILE} || die

	doinfo doc/zenirc.info
	dodoc BUGS INSTALL NEWS README TODO
	docinto doc
	dodoc doc/*

	elog "Refer to the Info documentation and ${SITELISP}/${PN}/zenirc-example.el for cusomtization hints"
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
