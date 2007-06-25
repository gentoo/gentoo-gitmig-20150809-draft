# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/remember/remember-1.9-r1.ebuild,v 1.1 2007/06/25 18:43:22 ulm Exp $

inherit elisp eutils

DESCRIPTION="Simplify writing short notes in emacs"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/RememberMode"
SRC_URI="http://download.gna.org/remember-el/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="bbdb planner"

RDEPEND="bbdb? ( app-emacs/bbdb )
	planner? ( app-emacs/planner )"
DEPEND="${RDEPEND}"

SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-make-elc.patch"

	# don't try to compile files with unsatisfied dependencies
	mkdir nocompile
	mv remember-{bibl,blosxom,emacs-wiki-journal}.el nocompile

	if ! use bbdb; then
		elog "bbdb USE flag not set - removing remember-bbdb.el"
		rm -f remember-bbdb.el
	fi
	if ! use planner; then
		elog "planner USE flag not set - removing remember-planner.el"
		rm -f remember-{planner,experimental}.el
	fi
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	elisp-install ${PN} *.{el,elc} nocompile/*.el
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	doinfo remember-el.info
	dodoc ChangeLog
}
