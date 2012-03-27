# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/core/core-107.01.ebuild,v 1.2 2012/03/27 21:33:16 aballier Exp $

EAPI="3"
inherit oasis

MY_P=${P/_/\~}
DESCRIPTION="Jane Street's alternative to the standard library"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://www.janestreet.com/ocaml/${P}.tar.gz"

LICENSE="LGPL-2.1-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-ml/res
	>=dev-ml/sexplib-5.2.1
	>=dev-ml/bin-prot-1.3.1
	>=dev-ml/fieldslib-0.1.2"
DEPEND="${RDEPEND}
	test? ( >=dev-ml/ounit-1.0.2 )"
