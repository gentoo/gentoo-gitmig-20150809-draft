# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/batteries/batteries-1.4.1.ebuild,v 1.1 2012/03/28 12:37:23 aballier Exp $

EAPI=4

inherit oasis

DESCRIPTION="The community-maintained foundation library for your OCaml projects"
HOMEPAGE="http://batteries.forge.ocamlcore.org/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/684/${P}.tar.gz"

LICENSE="LGPL-2.1-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-ml/camomile"
DEPEND="${RDEPEND}
	test? ( dev-ml/ounit )"

DOCS=( "ChangeLog" "FAQ" "README" "README.folders" "README.md" )
