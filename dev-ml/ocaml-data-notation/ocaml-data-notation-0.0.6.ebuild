# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-data-notation/ocaml-data-notation-0.0.6.ebuild,v 1.3 2012/03/27 21:33:31 aballier Exp $

EAPI=3

inherit oasis

DESCRIPTION="This project uses type-conv to dump OCaml data structure using OCaml data notation"
HOMEPAGE="https://forge.ocamlcore.org/projects/odn"
SRC_URI="https://forge.ocamlcore.org/frs/download.php/638/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-ml/type-conv-3.0.0"
DEPEND="${RDEPEND}
		  dev-ml/ounit[ocamlopt?]
		  dev-ml/ocaml-fileutils[ocamlopt?]"

PATCHES=( "${FILESDIR}/typeconv3.patch" )
DOCS=( "README.txt" )
