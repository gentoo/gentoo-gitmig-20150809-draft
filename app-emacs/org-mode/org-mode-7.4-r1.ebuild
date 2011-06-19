# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/org-mode/org-mode-7.4-r1.ebuild,v 1.2 2011/06/19 16:03:41 armin76 Exp $

EAPI=4
NEED_EMACS=22

inherit elisp

DESCRIPTION="An Emacs mode for notes and project planning"
HOMEPAGE="http://www.orgmode.org/"
SRC_URI="http://orgmode.org/org-${PV}.tar.gz"

LICENSE="GPL-3 FDL-1.3 contrib? ( GPL-2 MIT )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~sparc-fbsd ~x86-fbsd"
IUSE="contrib"

S="${WORKDIR}/org-${PV}"
SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	# Remove autoload file to make sure that it is regenerated with
	# the right Emacs version.
	rm -f lisp/org-install.el
}

# This is NOT redundant, elisp.eclass redefines src_compile.
src_compile() {
	emake
}

src_install() {
	emake \
		prefix="${D}/usr" \
		lispdir="${D}${SITELISP}/${PN}" \
		infodir="${D}/usr/share/info" \
		install

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	doinfo doc/org
	dodoc README Changes.org doc/org.pdf doc/orgcard.pdf doc/orgguide.pdf

	if use contrib; then
		elisp-install ${PN}/contrib contrib/lisp/*org*.el || die
		insinto /usr/share/doc/${PF}/contrib
		doins -r contrib/README contrib/babel contrib/scripts
		find "${D}/usr/share/doc/${PF}/contrib" -type f -name '.*' \
			-exec rm -f '{}' '+'
	fi
}
