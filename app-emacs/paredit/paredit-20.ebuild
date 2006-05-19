# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/paredit/paredit-20.ebuild,v 1.1 2006/05/19 04:34:15 mkennedy Exp $

inherit elisp

DESCRIPTION="Paredit mode is a minor mode for performing structured editing of S-expressions."
HOMEPAGE="http://mumble.net/~campbell/emacs/
	http://www.emacswiki.org/cgi-bin/wiki/ParEdit"
SRC_URI="http://mumble.net/~campbell/emacs/${P}.el
	http://mumble.net/~campbell/emacs/${P}.html"
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

SITEFILE=50paredit-gentoo.el

S=$WORKDIR

src_unpack() {
	for i in $DISTDIR/$P.{el,html}; do
		cp $i $S/paredit.${i//*.}
	done
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
	dohtml *.html
}
