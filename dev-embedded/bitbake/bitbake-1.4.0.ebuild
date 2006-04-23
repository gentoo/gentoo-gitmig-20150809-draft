# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/bitbake/bitbake-1.4.0.ebuild,v 1.1 2006/04/23 07:14:50 vapier Exp $

inherit eutils

DESCRIPTION="package management tool for OpenEmbedded"
HOMEPAGE="http://developer.berlios.de/projects/bitbake/"
SRC_URI="http://download.berlios.de/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="dev-lang/python"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/0-gentoo-paths.patch
}

src_install() {
	python setup.py install --root="${D}" || die "setup failed"
}
