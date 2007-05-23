# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/easypg/easypg-0.0.11-r2.ebuild,v 1.1 2007/05/23 17:31:47 opfer Exp $

inherit elisp

MY_PN=epg

DESCRIPTION="GnuPG interface for Emacs"
HOMEPAGE="http://www.easypg.org/"
SRC_URI="mirror://sourceforge.jp/epg/24683/${MY_PN}-${PV}.tar.gz
	gnus? ( mirror://sourceforge.jp/epg/24683/pgg-${MY_PN}.el )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnus"

DEPEND="app-crypt/gnupg"
RDEPEND="${DEPEND}
	gnus? ( virtual/gnus )"

SITEFILE=50${PN}-gentoo.el

S=${WORKDIR}/${MY_PN}-${PV}

src_compile(){
	econf
	emake || die "emake failed"
	elisp-make-autoload-file \
		|| die "elisp-make-autoload-file failed"

	if use gnus; then
		cp "${DISTDIR}/pgg-epg.el" "${WORKDIR}"
		elisp-compile "${WORKDIR}/pgg-epg.el" || die "elisp-compile failed"
	fi
}

src_install() {
	einstall || die "einstall failed"

	elisp-install ${MY_PN} ${PN}-autoloads.el
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" ${MY_PN}
	if use gnus; then
		elisp-install ${MY_PN} "${WORKDIR}"/pgg-epg.el{,c}
	fi
}

elisp_pkg_postinst() {
	elog "See the epa info page for more information"
	if use gnus; then
		elog "To use, add (setq pgg-scheme 'epg) to your ~/.gnus"
	fi
	elisp-site-regen
}
