# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/planner/planner-3.41-r2.ebuild,v 1.1 2007/06/26 06:41:30 ulm Exp $

inherit elisp

DESCRIPTION="Maintain a local Wiki using Emacs-friendly markup"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/PlannerMode"
SRC_URI="http://download.gna.org/planner-el/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=app-emacs/muse-3.02.6a
	app-emacs/bbdb
	app-emacs/emacs-w3m"
RDEPEND="${DEPEND}"
PDEPEND="app-emacs/remember"

SITEFILE=80${PN}-gentoo.el

src_compile() {
	emake || die
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	doinfo planner-el.info
	dodoc AUTHORS COMMENTARY ChangeLog* NEWS README || die "dodoc failed"
}
