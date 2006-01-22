# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/planner/planner-3.40.ebuild,v 1.1 2006/01/22 22:26:13 wrobel Exp $

inherit elisp

DESCRIPTION="Maintain a local Wiki using Emacs-friendly markup"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/PlannerMode"

# Upstream sources are not reliably available, so we use the Debian
# project's source archives

SRC_URI="http://download.gna.org/planner-el/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="
>=app-emacs/muse-3.02.6a
sys-apps/texinfo"

SITEFILE=80planner-gentoo.el

S="${WORKDIR}/${P}"

src_compile() {
	emake || die
}

src_install() {
	doinfo planner-el.info
	dodoc COMMENTARY
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install ${FILESDIR}/${SITEFILE}
}

pkg_postinst() {
	elisp-site-regen
}

pkg_postrm() {
	elisp-site-regen
}
