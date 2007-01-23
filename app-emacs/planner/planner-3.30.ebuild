# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/planner/planner-3.30.ebuild,v 1.2 2007/01/23 06:33:37 opfer Exp $

inherit elisp

DESCRIPTION="Maintain a local Wiki using Emacs-friendly markup"
HOMEPAGE="http://www.emacswiki.org/cgi-bin/wiki/PlannerMode"

# Upstream sources are not reliably available, so we use the Debian
# project's source archives

SRC_URI="mirror://debian/pool/main/p/planner-el/planner-el_${PV}.orig.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""
DEPEND="app-emacs/emacs-wiki
	sys-apps/texinfo"

SITEFILE=80planner-gentoo.el

S=${WORKDIR}/planner-el-${PV}

src_compile() {
	elisp-compile *.el
	makeinfo planner-el.texi || die
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc ChangeLog PLANNER-README
	doinfo planner-el.info*
}
