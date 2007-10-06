# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/wanderlust-cvs/wanderlust-cvs-2.15.ebuild,v 1.4 2007/10/06 19:49:53 ulm Exp $

ECVS_SERVER="cvs.m17n.org:/cvs/root"
ECVS_MODULE="wanderlust"
ECVS_BRANCH="HEAD"

inherit elisp cvs

DESCRIPTION="Wanderlust -- Yet Another Message Interface on Emacsen"
HOMEPAGE="http://www.gohome.org/wl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~alpha ~sparc ~ppc"
IUSE="ssl"

DEPEND="virtual/emacs
	>=app-emacs/apel-10.6
	virtual/flim
	app-emacs/semi
	!app-emacs/wanderlust"

S="${WORKDIR}/${ECVS_MODULE}"
SITEFILE="70wl-gentoo.el"

src_compile() {

	if use ssl ; then
		echo "(setq wl-install-utils t)" >> WL-CFG
	fi

	make || die
	make info || die
}

src_install() {

	make \
		LISPDIR="${D}"/usr/share/emacs/site-lisp \
		PIXMAPDIR="${D}"/usr/share/wl/icons \
		install || die

	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	dodir /usr/share/wl/samples

	insinto /usr/share/wl/samples/ja
	doins samples/ja/*
	insinto /usr/share/wl/samples/en
	doins samples/en/*

	doinfo doc/wl-ja.info doc/wl.info
	dodoc BUGS* ChangeLog INSTALL* README*
}
