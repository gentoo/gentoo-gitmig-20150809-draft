# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/planner/planner-3.41-r1.ebuild,v 1.3 2007/02/11 07:38:06 josejx Exp $

inherit elisp

DESCRIPTION="Maintain a local Wiki using Emacs-friendly markup"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/PlannerMode"
SRC_URI="http://download.gna.org/planner-el/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=app-emacs/muse-3.02.6a
	app-emacs/bbdb
	app-emacs/remember
	app-emacs/emacs-w3m"
RDEPEND="${DEPEND}"

SITEFILE=81planner-gentoo.el

S="${WORKDIR}/${P}"

src_compile() {
	emake || die
}

src_install() {
	doinfo planner-el.info
	dodoc COMMENTARY AUTHORS COPYING ChangeLog* NEWS README
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
}
