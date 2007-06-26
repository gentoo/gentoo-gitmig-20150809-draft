# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/remember/remember-1.9-r1.ebuild,v 1.2 2007/06/26 07:09:11 ulm Exp $

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
}

src_compile() {
	local EL="remember.el remember-diary.el read-file-name.el"
	use bbdb && EL="${EL} remember-bbdb.el"
	use planner && EL="${EL} remember-planner.el remember-experimental.el"

	emake EL="${EL}" || die "emake failed"
}

src_install() {
	elisp-install ${PN} *.{el,elc}
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	doinfo remember-el.info
	dodoc ChangeLog
}
