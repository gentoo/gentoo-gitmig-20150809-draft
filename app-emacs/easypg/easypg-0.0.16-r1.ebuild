# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/easypg/easypg-0.0.16-r1.ebuild,v 1.2 2009/11/23 13:35:06 maekke Exp $

inherit elisp

MY_PN=epg

DESCRIPTION="GnuPG interface for Emacs"
HOMEPAGE="http://www.easypg.org/"
SRC_URI="mirror://sourceforge.jp/epg/29289/${MY_PN}-${PV}.tar.gz
	gnus? ( mirror://sourceforge.jp/epg/25608/pgg-${MY_PN}.el )"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="gnus"

DEPEND="app-crypt/gnupg"
RDEPEND="${DEPEND}
	gnus? ( virtual/gnus )"

S="${WORKDIR}/${MY_PN}-${PV}"
SITEFILE="50${PN}-gentoo.el"

pkg_setup() {
	EMACS_VERSION=$(elisp-emacs-version)
	einfo "Emacs version: ${EMACS_VERSION}"
	if [ "${EMACS_VERSION%%.*}" -ge 23 ]; then
		echo
		elog "Please note that \"${PN}\" is already included with Emacs 23 or"
		elog "later, so ${CATEGORY}/${PN} is only needed for lower versions."
		elog "You may select the active Emacs version with \"eselect emacs\"."
	fi
}

src_unpack() {
	unpack ${A}
	use gnus && cp "${DISTDIR}/pgg-epg.el" "${S}"
}

src_compile() {
	econf
	emake || die "emake failed"
	elisp-make-autoload-file || die

	if use gnus && [ "${HAVE_EMACS%%.*}" -ge 22 ]; then
		# pgg-epg requires pgg, it will not compile with Emacs 21
		elisp-compile pgg-epg.el || die
	fi
}

src_install() {
	einstall || die "einstall failed"

	elisp-install ${MY_PN} ${PN}-autoloads.el || die
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" ${MY_PN} || die
	if use gnus; then
		elisp-install ${MY_PN} pgg-epg.el* || die
	fi
	# prevent inclusion of package dir by subdirs.el
	touch "${D}${SITELISP}/${MY_PN}/.nosearch" || die

	dodoc AUTHORS ChangeLog NEWS README || die
}

pkg_postinst() {
	elisp-site-regen
	elog "See the epa info page for more information"
	if use gnus; then
		elog "To use, add (setq pgg-scheme 'epg) to your ~/.gnus"
	fi
}
