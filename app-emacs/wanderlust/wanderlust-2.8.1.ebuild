# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/wanderlust/wanderlust-2.8.1.ebuild,v 1.5 2007/01/28 04:38:33 genone Exp $

inherit elisp

MY_P="${P/wanderlust/wl}"

DESCRIPTION="Wanderlust is a mail/news reader supporting IMAP4rev1 for emacsen"
HOMEPAGE="http://www.gohome.org/wl/"
SRC_URI="ftp://ftp.gohome.org/wl/stable/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="virtual/emacs
	>=app-emacs/apel-10.3
	virtual/flim
	virtual/semi
	!app-emacs/wanderlust-cvs"

S="${WORKDIR}/${MY_P}"

src_compile() {
	make || die
	make info || die
}

src_install() {
	make \
		LISPDIR=${D}/usr/share/emacs/site-lisp \
		PIXMAPDIR=${D}/usr/share/wl/icons \
		install || die

	elisp-site-file-install ${FILESDIR}/70wl-gentoo.el

	dodir /usr/share/wl/samples

	insinto /usr/share/wl/samples/ja
	doins samples/ja/*
	insinto /usr/share/wl/samples/en
	doins samples/en/*

	doinfo doc/wl-ja.info doc/wl.info
	dodoc BUGS* ChangeLog INSTALL* README*
}

pkg_postinst() {
	elisp-site-regen
	elog "Please see /usr/share/doc/${P}/INSTALL.gz."
	elog "And Sample configuration files exist on /usr/share/wl/samples."
}

pkg_postrm() {
	elisp-site-regen
}
