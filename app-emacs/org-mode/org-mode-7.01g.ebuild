# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/org-mode/org-mode-7.01g.ebuild,v 1.1 2010/07/27 20:36:30 fauli Exp $

NEED_EMACS=22

inherit elisp

DESCRIPTION="An Emacs mode for notes and project planning"
HOMEPAGE="http://www.orgmode.org/"
SRC_URI="http://orgmode.org/org-${PV}.tar.gz"

LICENSE="GPL-3 FDL-1.3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE=""

S="${WORKDIR}/org-${PV}"
SITEFILE="50${PN}-gentoo.el"

src_compile() {
	# remove autoload file to make sure that it is regenerated with
	# the right Emacs version
	rm -f lisp/org-install.el
	emake || die
}

src_install() {
	emake \
		prefix="${D}/usr" \
		lispdir="${D}${SITELISP}/${PN}" \
		infodir="${D}/usr/share/info" \
		install || die

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	mv doc/org doc/org.info
	doinfo doc/org.info || die "doinfo failed"
	dodoc README Changes.org doc/org.pdf doc/orgcard.pdf \
		|| die
	newdoc contrib/README README.contrib || die
}
