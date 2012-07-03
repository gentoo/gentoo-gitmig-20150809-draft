# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/core_extended/core_extended-108.00.01.ebuild,v 1.3 2012/07/03 17:38:32 mr_bones_ Exp $

EAPI="3"

OASIS_BUILD_DOCS=1
#FIXME!
#OASIS_BUILD_TESTS=1

inherit oasis

MY_P=${P/_/\~}
DESCRIPTION="Jane Street's alternative to the standard library"
HOMEPAGE="http://www.janestreet.com/ocaml"
SRC_URI="http://bitbucket.org/yminsky/ocaml-core/downloads/${P}.tar.gz"

LICENSE="LGPL-2.1-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

RDEPEND="dev-ml/pcre-ocaml
	>=dev-ml/sexplib-108.00.01
	>=dev-ml/bin-prot-108.00.01
	>=dev-ml/fieldslib-108.00.01
	>=dev-ml/pa_ounit-108.00.01
	>=dev-ml/variantslib-108.00.01
	>=dev-ml/pipebang-108.00.01"
DEPEND="${RDEPEND}
	test? ( >=dev-ml/ounit-1.1.0 )"
