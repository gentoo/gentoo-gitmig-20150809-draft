# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/wanderlust/wanderlust-2.10.1-r2.ebuild,v 1.9 2007/03/31 09:42:24 grobian Exp $

inherit elisp eutils

MY_P="${P/wanderlust/wl}"

IUSE="ssl"

DESCRIPTION="Wanderlust is a mail/news reader supporting IMAP4rev1 for emacsen"
HOMEPAGE="http://www.gohome.org/wl/"
SRC_URI="ftp://ftp.gohome.org/wl/stable/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}-20040602.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha sparc ppc"

DEPEND="virtual/emacs
	>=app-emacs/apel-10.6
	virtual/flim
	virtual/semi
	!app-emacs/wanderlust-cvs"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/${MY_P}-20040602.diff.gz

	use ssl && echo "(setq wl-install-utils t)" >> WL-CFG
}

src_compile() {
	make || die
	make info || die
}

src_install() {
	make \
		LISPDIR=${D}/usr/share/emacs/site-lisp \
		PIXMAPDIR=${D}/usr/share/wl/icons \
		install || die

	elisp-site-file-install ${FILESDIR}/70wl-gentoo.el || die

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
