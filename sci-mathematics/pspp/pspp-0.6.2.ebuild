# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/pspp/pspp-0.6.2.ebuild,v 1.1 2009/11/21 08:29:49 bicatali Exp $

EAPI=2
inherit eutils elisp-common autotools

DESCRIPTION="Program for statistical analysis of sampled data."
HOMEPAGE="http://www.gnu.org/software/pspp/pspp.html"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="doc emacs gtk ncurses nls plotutils postgres"

RDEPEND="sci-libs/gsl
	sys-libs/readline
	sys-devel/gettext
	virtual/libiconv
	sys-libs/zlib
	dev-libs/libxml2
	emacs? ( virtual/emacs )
	gtk? ( >=x11-libs/gtk+-2.12 gnome-base/libglade )
	ncurses? ( sys-libs/ncurses )
	plotutils? ( media-libs/plotutils )
	postgres? ( virtual/postgresql-server )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( virtual/latex-base )"

SITEFILE=50${PN}-gentoo.el

src_prepare() {
	# this patch is hacky, but should not be needed for 0.7
	epatch "${FILESDIR}"/${PN}-0.6.0-as-needed.patch
	eautoreconf
}

src_configure() {
	econf \
		--disable-rpath \
		$(use_enable nls) \
		$(use_with gtk gui) \
		$(use_with ncurses libncurses) \
		$(use_with plotutils libplot) \
		$(use_with postgres libpq)
}

src_compile() {
	emake pkglibdir=/usr/$(get_libdir) || die "emake failed"
	if use doc; then
		emake html || die "emake html failed"
		emake pdf || die "emake pdf failed"
	fi
	use emacs && elisp-compile *.el
}

src_install() {
	emake pkglibdir=/usr/$(get_libdir) DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog NEWS ONEWS README THANKS TODO
	insinto /usr/share/doc/${PF}
	doins -r examples || die

	if use doc; then
		doins -r doc/pspp.html doc/pspp-dev.html || die
		doins doc/pspp.pdf doc/pspp-dev.pdf || die
	fi
	if use emacs; then
		elisp-install ${PN} *.el *.elc
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi

	if use gtk; then
		doicon src/ui/gui/${PN}icon.png
		make_desktop_entry psppire psppire ${PN}icon.png
	fi
}

pkg_postinst () {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
