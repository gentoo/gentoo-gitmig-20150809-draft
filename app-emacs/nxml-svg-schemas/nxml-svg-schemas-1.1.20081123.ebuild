# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/nxml-svg-schemas/nxml-svg-schemas-1.1.20081123.ebuild,v 1.1 2008/11/23 19:33:41 flameeyes Exp $

inherit elisp

DESCRIPTION="Extension for nxml-mode with SVG 1.1 schemas"
HOMEPAGE="http://www.w3.org/TR/SVG11/"

# original SRC_URI is http://www.w3.org/Graphics/SVG/1.1/rng/rng.zip
# but since it's unversioned, I versioned it and got it locally.
SRC_URI="http://www.flameeyes.eu/gentoo-distfiles/w3c-svg-rng-${PV}.zip"

# This is truly as-is!
LICENSE="as-is"

# In a future we might have 1.2 schemas too, but for now we can only
# install this one anyway because the schemas.xml syntax is not
# sophisticated enough.
SLOT="1.1"

KEYWORDS="~amd64"
IUSE=""

RDEPEND="|| ( >=app-emacs/nxml-mode-20041004-r3 >=virtual/emacs-23 )"

# Yes this requires Java, but I'd rather not repackage this, if you
# know something better in C, I'll be glad to use that.
DEPEND="app-text/trang"

SITEFILE=60${PN}-gentoo.el

S="${WORKDIR}"

src_unpack() {
	unpack ${A}

	# we don't need the doctype for our work
	sed -i -e '/DOCTYPE grammar/d' *.rng || die "sed failed"
}

src_compile() {
	emake -f "${FILESDIR}/Makefile-trang" || die "trang failed"
}

src_install() {
	insinto ${SITEETC}/${PN}
	doins "${FILESDIR}/schemas.xml" *.rnc || die "install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
}

pkg_postinst () {
	elisp-site-regen

	if [ $(emacs -batch -q --eval "(princ (fboundp 'nxml-mode))") = nil ]; then
		ewarn "This package needs nxml-mode. You should either install"
		ewarn "app-emacs/nxml-mode, or use \"eselect emacs\" to select"
		ewarn "an Emacs version >= 23."
	fi
}
