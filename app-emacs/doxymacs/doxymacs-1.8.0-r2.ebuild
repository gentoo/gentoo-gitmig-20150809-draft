# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/doxymacs/doxymacs-1.8.0-r2.ebuild,v 1.3 2009/03/02 18:36:22 ulm Exp $

NEED_EMACS=22

inherit elisp flag-o-matic

DESCRIPTION="Doxygen editing minor mode"
HOMEPAGE="http://doxymacs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=">=dev-libs/libxml2-2.6.13"
RDEPEND="${DEPEND}"

DOCS="AUTHORS ChangeLog NEWS README TODO"
SITEFILE="50${PN}-gentoo.el"

src_compile() {
	append-flags -Wno-error		#260874
	econf \
		--with-datadir="${SITELISP}/${PN}" \
		--with-lispdir="${SITELISP}/${PN}" \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake \
		prefix="${D}/usr" \
		datadir="${D}/${SITELISP}/${PN}" \
		lispdir="${D}/${SITELISP}/${PN}" \
		install \
		|| die "emake install failed"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	dodoc ${DOCS} || die "dodoc failed"
}
