# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-mathematics/pspp/pspp-0.6.2-r1.ebuild,v 1.3 2012/04/24 10:41:15 mgorny Exp $

EAPI=4
inherit eutils elisp-common autotools

DESCRIPTION="Program for statistical analysis of sampled data."
HOMEPAGE="http://www.gnu.org/software/pspp/pspp.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86"
IUSE="doc emacs gtk ncurses nls plotutils postgres static-libs"

RDEPEND="sci-libs/gsl
	sys-libs/readline
	sys-devel/gettext
	virtual/libiconv
	sys-libs/zlib
	dev-libs/libxml2:2
	emacs? ( virtual/emacs )
	gtk? ( x11-libs/gtk+:2 gnome-base/libglade:2.0 gnome-extra/yelp )
	ncurses? ( sys-libs/ncurses )
	plotutils? ( media-libs/plotutils )
	postgres? ( dev-db/postgresql-server )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( virtual/latex-base )"

SITEFILE=50${PN}-gentoo.el

src_prepare() {
	# this patch is hacky, but should not be needed for 0.7
	epatch "${FILESDIR}"/${PN}-0.6.0-as-needed.patch
	epatch "${FILESDIR}"/${PN}-0.6.2-no-test-pgsql.patch
	epatch "${FILESDIR}"/${PN}-0.6.2-gtk.patch
	sed -i \
		-e '/xdate/d' \
		-e '/datediff/d' \
		tests/expressions/expressions.sh || die
	eautoreconf
}

src_configure() {
	econf \
		--disable-rpath \
		$(use_enable nls) \
		$(use_enable static-libs static) \
		$(use_with gtk gui) \
		$(use_with ncurses libncurses) \
		$(use_with plotutils libplot) \
		$(use_with postgres libpq)
}

src_compile() {
	emake pkglibdir="${EPREFIX}/usr/$(get_libdir)"
	use doc && emake html && emake pdf
	use emacs && elisp-compile *.el
}

src_install() {
	emake pkglibdir="${EPREFIX}/usr/$(get_libdir)" DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS ONEWS README THANKS TODO
	insinto /usr/share/doc/${PF}
	doins -r examples
	if use doc; then
		doins -r doc/pspp.html doc/pspp-dev.html
		doins doc/pspp.pdf doc/pspp-dev.pdf
	fi
	if use emacs; then
		elisp-install ${PN} *.el *.elc
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
	if use gtk; then
		doicon src/ui/gui/${PN}icon.png
		make_desktop_entry psppire psppire ${PN}icon
	fi
}

pkg_postinst () {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
