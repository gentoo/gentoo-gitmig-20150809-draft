# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdvi/kdvi-3.5.6.ebuild,v 1.3 2007/06/20 16:12:33 philantrop Exp $

KMNAME=kdegraphics
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils elisp-common

DESCRIPTION="KDE DVI viewer"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="emacs tetex"

DEPEND="$(deprange $PV $MAXKDEVER kde-base/kviewshell)
	>=media-libs/freetype-2
	emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}
	tetex? ( virtual/tetex )"

KMCOMPILEONLY="kviewshell/"

src_compile() {
	kde-meta_src_compile

	if use emacs; then
		cd "${S}/doc/kdvi"
		elisp-compile kdvi-search.el
	fi
}

src_install() {
	kde-meta_src_install

	if use emacs; then
		insinto "${SITELISP}"
		doins doc/kdvi/kdvi-search.el*
		elisp-site-file-install "${FILESDIR}/50kdvi-gentoo.el"
	fi
}

pkg_postinst() {
	kde_pkg_postinst
	use emacs && elisp-site-regen
}

pkg_postrm() {
	kde_pkg_postrm
	use emacs && elisp-site-regen
}
