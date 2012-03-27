# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/react/react-0.9.3.ebuild,v 1.2 2012/03/27 21:03:58 aballier Exp $

EAPI="4"

inherit oasis

DESCRIPTION="OCaml module for functional reactive programming"
HOMEPAGE="http://erratique.ch/software/react"
SRC_URI="http://erratique.ch/software/react/releases/${P}.tbz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE="test"

DEPEND=""
RDEPEND="${DEPEND}"

DOCS=( "CHANGES" "README" )

src_configure() {
	oasis_configure_opts="$(use_enable test tests)" \
		oasis_src_configure
}
