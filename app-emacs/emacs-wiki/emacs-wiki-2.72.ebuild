# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-wiki/emacs-wiki-2.72.ebuild,v 1.2 2007/06/26 01:35:16 mr_bones_ Exp $

inherit elisp

DESCRIPTION="Maintain a local Wiki using Emacs-friendly markup"
HOMEPAGE="http://www.mwolson.org/projects/EmacsWiki.html
	http://www.emacswiki.org/cgi-bin/wiki.pl?EmacsWikiMode"
SRC_URI="http://www.mwolson.org/static/dist/emacs-wiki/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
# No tests, for there is no app-emacs/pgg
RESTRICT="test"

DEPEND="app-emacs/htmlize
	app-emacs/table
	app-emacs/httpd
	sys-apps/texinfo"

SITEFILE=50emacs-wiki-gentoo.el

src_unpack() {
	unpack ${A}
	# These will be made part of the emacs-wiki installation until
	# they are packaged separately
	mv ${S}/contrib/{update-remote,cgi}.el ${S}/
}

src_compile() {
	elisp-comp *.el	|| die
	makeinfo emacs-wiki.texi || die
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	doinfo *.info*
	dodoc ChangeLog*
	docinto examples
	dodoc examples/default.css
}
