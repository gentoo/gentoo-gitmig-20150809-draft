# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/core_extended/core_extended-107.01.ebuild,v 1.1 2012/03/28 12:04:12 aballier Exp $

EAPI=4

OASIS_BUILD_DOCS=1

inherit oasis

DESCRIPTION="Jane Street's extended library"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://www.janestreet.com/ocaml/${P}.tar.gz"

LICENSE="LGPL-2.1-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-ml/res
	>=dev-ml/sexplib-7.0.4
	>=dev-ml/core-107.01
	>=dev-ml/bin-prot-2.0.3
	>=dev-ml/fieldslib-0.1.2"
DEPEND="${RDEPEND}
	test? ( >=dev-ml/ounit-1.1.1 )"
