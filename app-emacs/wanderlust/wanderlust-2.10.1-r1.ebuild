# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/wanderlust/wanderlust-2.10.1-r1.ebuild,v 1.2 2004/06/01 14:09:05 vapier Exp $

inherit elisp

MY_P="${P/wanderlust/wl}"

IUSE="ssl"

DESCRIPTION="Wanderlust is a mail/news reader supporting IMAP4rev1 for emacsen"
HOMEPAGE="http://www.gohome.org/wl/"
SRC_URI="ftp://ftp.gohome.org/wl/stable/${MY_P}.tar.gz"

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
	unpack ${A}
	if [ -n "`use ssl`" ] ; then
		cd ${S}
		echo "(setq wl-install-utils t)" >> WL-CFG
	fi
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
	einfo "Please see /usr/share/doc/${P}/INSTALL.gz."
	einfo "And Sample configuration files exist on /usr/share/wl/samples."
}

pkg_postrm() {
	elisp-site-regen
}
