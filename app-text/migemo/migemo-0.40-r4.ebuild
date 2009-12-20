# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/migemo/migemo-0.40-r4.ebuild,v 1.1 2009/12/20 16:48:56 ulm Exp $

EAPI=2

inherit elisp-common eutils

DESCRIPTION="Migemo is Japanese Incremental Search Tool"
HOMEPAGE="http://0xcc.net/migemo/"
SRC_URI="http://0xcc.net/migemo/stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="emacs"

DEPEND="dev-lang/ruby
	dev-ruby/ruby-romkan
	dev-ruby/ruby-bsearch
	app-dicts/migemo-dict[-unicode]
	emacs? ( virtual/emacs
		app-emacs/apel )"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	cp "${ROOT}"/usr/share/migemo/migemo-dict .
	epatch "${FILESDIR}/${P}-without-emacs.patch"
}

src_configure() {
	econf $(use_with emacs) --with-lispdir="${SITELISP}/${PN}"
}

src_compile() {
	emake -j1 || die
}

src_install() {
	emake -j1 DESTDIR="${D}" \
		$(use emacs || echo "lispdir=") install || die

	rm "${D}"/usr/share/migemo/migemo-dict

	if use emacs; then
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	fi
	dodoc AUTHORS ChangeLog INSTALL README
}

pkg_postinst() {
	if use emacs; then
		elisp-site-regen
		elog "Migemo adviced search is no longer enabled as a site default."
		elog "Add the following line to your ~/.emacs file to enable it:"
		elog "  (require 'migemo)"
	fi
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
