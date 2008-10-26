# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mew/mew-6.1.ebuild,v 1.5 2008/10/26 14:46:26 nixnut Exp $

inherit elisp

DESCRIPTION="Great MIME mail reader for Emacs/XEmacs"
HOMEPAGE="http://www.mew.org/"
SRC_URI="http://www.mew.org/Release/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ppc sparc x86"
IUSE="ssl linguas_ja"
RESTRICT="test"

RDEPEND="ssl? ( net-misc/stunnel )"

SITEFILE=50${PN}-gentoo.el

src_compile() {
	econf \
		--with-elispdir=${SITELISP}/${PN} \
		--with-etcdir=/usr/share/${PN} || die "econf failed"
	emake || die "emake failed"

	if use linguas_ja; then
		emake jinfo || die "emake jinfo failed"
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	if use linguas_ja; then
		emake DESTDIR="${D}" install-jinfo || die "emake install-jinfo failed"
	fi

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"

	dodoc 00api 00changes* 00diff 00readme mew.dot.* || die "dodoc failed"
}

pkg_postinst() {
	elisp-site-regen
	elog
	elog "Please refer to /usr/share/doc/${PF} for sample configuration files."
	elog
}
