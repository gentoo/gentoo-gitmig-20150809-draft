# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/muse/muse-3.20.ebuild,v 1.8 2010/05/23 18:21:21 pacho Exp $

inherit elisp

DESCRIPTION="Muse-mode is similar to EmacsWikiMode, but more focused on publishing to various formats"
HOMEPAGE="http://mwolson.org/projects/EmacsMuse.html"
SRC_URI="http://download.gna.org/muse-el/${P}.tar.gz"

LICENSE="GPL-3 FDL-1.2 GPL-2 MIT"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"
IUSE="test"

DEPEND="test? ( app-emacs/htmlize )"
RDEPEND=""

SITEFILE="50${PN}-gentoo.el"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	elisp-install ${PN} lisp/*.el lisp/*.elc || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	doinfo texi/muse.info || die
	dodoc AUTHORS NEWS README ChangeLog* || die "dodoc failed"
	insinto /usr/share/doc/${PF}
	doins -r contrib etc examples experimental scripts || die
}
