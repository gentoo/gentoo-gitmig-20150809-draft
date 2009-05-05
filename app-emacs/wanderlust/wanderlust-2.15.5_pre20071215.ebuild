# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/wanderlust/wanderlust-2.15.5_pre20071215.ebuild,v 1.2 2009/05/05 08:13:03 fauli Exp $

inherit elisp

DESCRIPTION="Yet Another Message Interface on Emacsen"
HOMEPAGE="http://www.gohome.org/wl/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="bbdb ssl"

DEPEND=">=app-emacs/apel-10.6
	virtual/flim
	app-emacs/semi
	bbdb? ( app-emacs/bbdb )
	!app-emacs/wanderlust-cvs"
RDEPEND="${DEPEND}"

SITEFILE=70wl-gentoo.el

src_compile() {
	use ssl && echo "(setq wl-install-utils t)" >> WL-CFG
	emake || die "emake failed"
	emake info || die "emake info failed"
}

src_install() {
	emake \
		LISPDIR="${D}${SITELISP}" \
		PIXMAPDIR="${D}/usr/share/wl/icons" \
		install || die "emake install failed"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" wl \
		|| die "elisp-site-file-install failed"

	insinto /usr/share/wl/samples/ja
	doins samples/ja/*
	insinto /usr/share/wl/samples/en
	doins samples/en/*

	doinfo doc/wl-ja.info doc/wl.info
	dodoc BUGS* ChangeLog INSTALL* NEWS* README*
}
