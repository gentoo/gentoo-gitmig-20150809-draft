# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/org-mode/org-mode-7.3.ebuild,v 1.4 2010/12/22 01:23:53 hwoarang Exp $

EAPI=3
NEED_EMACS=22

inherit elisp

DESCRIPTION="An Emacs mode for notes and project planning"
HOMEPAGE="http://www.orgmode.org/"
SRC_URI="http://orgmode.org/org-${PV}.tar.gz"

LICENSE="GPL-3 FDL-1.3 contrib? ( GPL-2 MIT )"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86 ~sparc-fbsd ~x86-fbsd"
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
	emake || die
}

src_install() {
	emake \
		prefix="${D}/usr" \
		lispdir="${D}${SITELISP}/${PN}" \
		infodir="${D}/usr/share/info" \
		install || die

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	doinfo doc/org || die "doinfo failed"
	dodoc README Changes.org doc/org.pdf doc/orgcard.pdf doc/orgguide.pdf \
		|| die

	if use contrib; then
		elisp-install ${PN}/contrib contrib/lisp/*org*.el || die
		insinto /usr/share/doc/${PF}/contrib
		doins -r contrib/README contrib/babel contrib/scripts || die
		find "${D}/usr/share/doc/${PF}/contrib" -type f -name '.*' \
			-exec rm -f '{}' '+'
		prepalldocs				# FIXME: remove in EAPI 4
	fi
}
