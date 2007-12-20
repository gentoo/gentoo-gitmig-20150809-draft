# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/migemo/migemo-0.40-r2.ebuild,v 1.2 2007/12/20 14:05:13 matsuu Exp $

inherit elisp-common

DESCRIPTION="Migemo is Japanese Incremental Search Tool"
HOMEPAGE="http://0xcc.net/migemo/"
SRC_URI="http://0xcc.net/migemo/stable/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="emacs"

RDEPEND="virtual/ruby
	dev-ruby/ruby-romkan
	dev-ruby/ruby-bsearch
	app-dicts/migemo-dict
	emacs? ( virtual/emacs )"

DEPEND="${RDEPEND}
	virtual/emacs
	app-emacs/apel"

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cp /usr/share/migemo/migemo-dict "${S}"
}

src_compile() {
	econf || die
	# emake b0rks
	emake -j1 || die
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die

	rm "${D}"/usr/share/migemo/migemo-dict

	if use emacs ; then
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	fi
	dodoc AUTHORS ChangeLog INSTALL README
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}
