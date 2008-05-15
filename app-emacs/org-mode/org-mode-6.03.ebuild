# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/org-mode/org-mode-6.03.ebuild,v 1.1 2008/05/15 15:37:22 ulm Exp $

inherit elisp

DESCRIPTION="An Emacs mode for notes and project planning"
HOMEPAGE="http://www.orgmode.org/"
SRC_URI="http://orgmode.org/org-${PV}.tar.gz"

LICENSE="GPL-3 FDL-1.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

SITEFILE=51${PN}-gentoo.el

S="${WORKDIR}/org-${PV}"

src_compile() {
	# remove autoload file to make sure that it is regenerated with
	# the right Emacs version
	rm -f lisp/org-install.el
	emake || die "emake failed"
}

src_install() {
	emake \
		prefix="${D}/usr" \
		lispdir="${D}${SITELISP}/${PN}" \
		infodir="${D}/usr/share/info" \
		install || die "emake install failed"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"

	mv doc/org doc/org.info
	doinfo doc/org.info || die "doinfo failed"
	dodoc README ChangeLog Changes.org doc/org.pdf doc/orgcard.pdf \
		|| die "dodoc failed"
}
