# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/pspp/pspp-0.4.0.ebuild,v 1.4 2008/02/03 12:03:23 markusle Exp $

inherit elisp-common

DESCRIPTION="Program for statistical analysis of sampled data."
HOMEPAGE="http://www.gnu.org/software/pspp/pspp.html"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="bindist doc ncurses emacs plotutils nls"

DEPEND="!bindist? ( sci-libs/gsl )
	bindist? ( <sci-libs/gsl-1.10 )
	sys-libs/readline
	>=sys-devel/gettext-0.14.1
	>=dev-lang/perl-5.6
	ncurses? ( >=sys-libs/ncurses-5.4 )
	plotutils? ( >=media-libs/plotutils-2.4.1 )
	emacs? ( virtual/emacs )"

# make check gave 39 failures of out 96 tests
RESTRICT="test"
SITEFILE=50${PN}-gentoo.el

src_compile() {
	econf \
		$(use_with plotutils libplot) \
		$(use_with ncurses) \
		$(use_enable nls) \
		|| die "econf failed"
	emake || die "emake failed"
	if use doc; then
		emake html || die "emake html failed"
	fi

	use emacs && elisp-compile *.el

}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog \
		INSTALL NEWS ONEWS README THANKS TODO
	docinto examples && dodoc examples/{ChangeLog,descript.stat}

	use doc && dohtml doc/pspp.html/*
	if use emacs; then
		elisp-install ${PN} *.el *.elc
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst () {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
