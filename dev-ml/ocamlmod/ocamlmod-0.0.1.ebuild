# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocamlmod/ocamlmod-0.0.1.ebuild,v 1.1 2012/03/28 12:24:03 aballier Exp $

EAPI=4

inherit oasis

DESCRIPTION="Generate OCaml modules from source files"
HOMEPAGE="http://forge.ocamlcore.org/projects/ocamlmod/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/623/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-ml/ocaml-fileutils
	dev-ml/pcre-ocaml"
RDEPEND="${DEPEND}"

STRIP_MASK="*/bin/*"
DOCS=( "AUTHORS.txt" "README.txt" )
