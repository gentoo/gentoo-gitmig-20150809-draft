# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/wanderlust/wanderlust-2.11.24_pre20040209.ebuild,v 1.2 2004/03/04 19:16:41 usata Exp $

inherit elisp

MY_P="wl-${PV/_pre/.}"

IUSE="ssl"

DESCRIPTION="Wanderlust -- Yet Another Message Interface on Emacsen"
HOMEPAGE="http://www.gohome.org/wl/"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# Please do not mark it stable since this is merely a CVS snapshot
KEYWORDS="~x86 ~alpha ~sparc ~ppc"

DEPEND="virtual/emacs
	>=app-emacs/apel-10.6
	virtual/flim
	virtual/semi
	!app-emacs/wanderlust-cvs"

S="${WORKDIR}/${PN}"

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
