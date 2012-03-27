# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/xmlm/xmlm-1.1.0.ebuild,v 1.1 2012/03/27 21:16:25 aballier Exp $

EAPI=3

inherit oasis

DESCRIPTION="Ocaml XML manipulation module"
HOMEPAGE="http://erratique.ch/software/xmlm"
SRC_URI="http://erratique.ch/software/${PN}/releases/${P}.tbz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( "CHANGES" "README" )

src_configure() {
	oasis_configure_opts="$(use_enable test tests)" \
		oasis_src_configure
}
