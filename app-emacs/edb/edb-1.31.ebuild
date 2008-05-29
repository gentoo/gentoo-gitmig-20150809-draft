# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/edb/edb-1.31.ebuild,v 1.1 2008/05/29 16:24:19 ulm Exp $

inherit elisp eutils

DESCRIPTION="EDB, The Emacs Database"
HOMEPAGE="http://www.gnuvola.org/software/edb/"
SRC_URI="http://www.gnuvola.org/software/edb/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE=""

SITEFILE="52${PN}-gentoo.el"

src_compile() {
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	einstall sitelisp="${D}${SITELISP}" || die "einstall failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"
	dodoc AUTHORS BUGS ChangeLog HACKING NEWS README THANKS TODO \
		doc/refcard.ps || die "dodoc failed"
	insinto /usr/share/doc/${PF}; doins -r examples
}
