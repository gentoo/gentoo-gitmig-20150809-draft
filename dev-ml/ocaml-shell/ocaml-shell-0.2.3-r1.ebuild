# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/ocaml-shell/ocaml-shell-0.2.3-r1.ebuild,v 1.3 2003/09/08 03:01:53 msterret Exp $

DESCRIPTION="O'Caml modules for running shell commands and pipelines"
HOMEPAGE="http://www.ocaml-programming.de/packages/documentation/shell/"
SRC_URI="http://www.ocaml-programming.de/packages/shell-${PV}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86"

DEPEND=">=dev-lang/ocaml-3.06
	>=dev-ml/findlib-0.8"
IUSE=""
S="${WORKDIR}/shell-${PV}"

src_compile() {
	make all opt || die
}

src_install() {
	# must create destdir beforehand
	destdir=`ocamlfind printconf destdir`
	mkdir -p ${D}${destdir} || die
	# install
	make INSTALLDIR=${D}${destdir}/shell conventional-install || die

	dodoc doc/README
}
