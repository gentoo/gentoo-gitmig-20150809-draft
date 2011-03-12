# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/nxml-svg-schemas/nxml-svg-schemas-1.1.20081123.ebuild,v 1.3 2011/03/12 14:42:45 ulm Exp $

NEED_EMACS=23
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
KEYWORDS="~amd64 ~x86"
IUSE=""

# Yes this requires Java, but I'd rather not repackage this, if you
# know something better in C, I'll be glad to use that.
DEPEND="app-text/trang"
RDEPEND=""

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
