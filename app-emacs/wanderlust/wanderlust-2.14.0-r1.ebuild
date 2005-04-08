# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/wanderlust/wanderlust-2.14.0-r1.ebuild,v 1.1 2005/04/08 16:34:00 usata Exp $

inherit elisp eutils

MY_P="wl-${PV/_/}"

IUSE="ssl"

DESCRIPTION="Wanderlust -- Yet Another Message Interface on Emacsen"
HOMEPAGE="http://www.gohome.org/wl/"
SRC_URI="ftp://ftp.gohome.org/wl/stable/${MY_P}.tar.gz
	ftp://ftp.gohome.org/wl/beta/${MY_P}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${MY_P}-20050405.diff"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc ~ppc ~ppc-macos"

DEPEND=">=app-emacs/apel-10.6
	virtual/flim
	virtual/semi
	!app-emacs/wanderlust-cvs"

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${MY_P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/${MY_P}-20050405.diff
}

src_compile() {
	use ssl && echo "(setq wl-install-utils t)" >> WL-CFG
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
