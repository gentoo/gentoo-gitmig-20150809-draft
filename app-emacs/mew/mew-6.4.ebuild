# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mew/mew-6.4.ebuild,v 1.1 2011/11/21 13:08:13 ulm Exp $

EAPI=4

inherit elisp

DESCRIPTION="Great MIME mail reader for Emacs/XEmacs"
HOMEPAGE="http://www.mew.org/"
SRC_URI="http://www.mew.org/Release/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE="ssl linguas_ja"
RESTRICT="test"

RDEPEND="ssl? ( net-misc/stunnel )"

SITEFILE="50${PN}-gentoo.el"

src_configure() {
	econf \
		--with-elispdir="${SITELISP}/${PN}" \
		--with-etcdir="${SITEETC}/${PN}"
}

src_compile() {
	emake
	use linguas_ja && emake jinfo
}

src_install() {
	emake DESTDIR="${D}" install
	use linguas_ja && emake DESTDIR="${D}" install-jinfo

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc 00api 00changes* 00diff 00readme dot.*
}

pkg_postinst() {
	elisp-site-regen
	elog "Please refer to /usr/share/doc/${PF} for sample configuration files."
}
