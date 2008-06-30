# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/pspp/pspp-0.6.0.ebuild,v 1.1 2008/06/30 13:28:44 markusle Exp $

inherit elisp-common autotools

DESCRIPTION="Program for statistical analysis of sampled data."
HOMEPAGE="http://www.gnu.org/software/pspp/pspp.html"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="doc ncurses emacs plotutils nls psppire"

RDEPEND="sci-libs/gsl
	sys-libs/readline
	>=sys-devel/gettext-0.14.1
	>=dev-lang/perl-5.6
	virtual/libiconv
	ncurses? ( >=sys-libs/ncurses-5.4 )
	plotutils? ( >=media-libs/plotutils-2.4.1 )
	emacs? ( virtual/emacs )
	psppire? ( >=x11-libs/gtk+-2.12
			>=gnome-base/libglade-2.6 )"

DEPEND="${RDEPEND}
	psppire? ( dev-util/pkgconfig )"


SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-disable-inline.patch
	eautoreconf
}


src_compile() {
	econf \
		$(use_with plotutils libplot) \
		$(use_with ncurses libncurses) \
		$(use_enable nls) \
		$(use_with psppire gui) \
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

	if use psppire; then
		make_desktop_entry psppire psppire src/ui/gui/${PN}icon.png
	fi
}

pkg_postinst () {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
