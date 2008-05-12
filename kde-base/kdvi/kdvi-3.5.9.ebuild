# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdvi/kdvi-3.5.9.ebuild,v 1.4 2008/05/12 20:02:36 ranger Exp $

KMNAME=kdegraphics
EAPI="1"
inherit kde-meta eutils elisp-common

DESCRIPTION="KDE DVI viewer"
KEYWORDS="alpha ~amd64 ~hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="emacs tetex"

DEPEND=">=kde-base/kviewshell-${PV}:${SLOT}
	>=media-libs/freetype-2.3
	emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}
	tetex? ( virtual/tetex )"

KMCOMPILEONLY="kviewshell/"
SITEFILE=50${PN}-gentoo.el

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
		elisp-install ${PN} doc/kdvi/kdvi-search.el*
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
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
