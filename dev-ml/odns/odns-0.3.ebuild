# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/odns/odns-0.3.ebuild,v 1.1 2011/03/04 12:33:02 aballier Exp $

EAPI=3

inherit findlib

DESCRIPTION="OCaml library to query DNS servers"
HOMEPAGE="http://odns.tuxfamily.org/"
SRC_URI="http://download.tuxfamily.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND=">=dev-lang/ocaml-3.10.2[ocamlopt]"
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i -e "s/version=\"0.2\"/version=\"${PV}\"/" META || die
}

src_install() {
	findlib_src_preinst
	PREFIX="${D}/usr" emake install || die
	dodoc AUTHORS README || die
}
