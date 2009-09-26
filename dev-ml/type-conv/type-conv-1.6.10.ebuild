# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/type-conv/type-conv-1.6.10.ebuild,v 1.1 2009/09/26 12:23:48 aballier Exp $

EAPI="2"

inherit findlib

DESCRIPTION="Mini library required for some other preprocessing libraries"
HOMEPAGE="http://www.ocaml.info/home/ocaml_sources.html"
SRC_URI="http://ocaml.info/ocaml_sources/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=">=dev-lang/ocaml-3.10"
RDEPEND="${DEPEND}"

src_install() {
	findlib_src_preinst
	emake install || die "make install failed"
	dodoc README.txt Changelog
}
