# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/oasis/oasis-0.3.0_rc3.ebuild,v 1.1 2012/03/28 12:45:00 aballier Exp $

EAPI=3

OASIS_BUILD_TESTS=1
OASIS_BUILD_DOCS=1

inherit oasis

MY_P=${P/_/\~}
DESCRIPTION="OASIS is a tool to integrate a configure, build and install system in OCaml project"
HOMEPAGE="http://oasis.forge.ocamlcore.org/index.php"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/829/${MY_P}.tar.gz"

LICENSE="LGPL-2.1-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-ml/ocaml-fileutils-0.4.2
		dev-ml/batteries
		dev-ml/pcre-ocaml
		>=dev-ml/ocaml-data-notation-0.0.3
		dev-ml/ocamlgraph"
DEPEND="${RDEPEND}
	dev-ml/ocamlify
	dev-ml/ocamlmod
	test? (
		>=dev-ml/ounit-1.1.0
		>=dev-ml/ocaml-expect-0.0.2
		dev-ml/extlib
	)"

STRIP_MASK="*/bin/*"
S="${WORKDIR}/${MY_P}"
DOCS=( "README.txt" "TODO.txt" "AUTHORS.txt" "CHANGES.txt" )
