# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-fiveam/cl-fiveam-1.2.3.ebuild,v 1.2 2005/03/18 08:02:23 mkennedy Exp $

inherit common-lisp

DESCRIPTION="FiveAM is a simple regression testing framework for Common Lisp."
HOMEPAGE="http://common-lisp.net/project/bese/FiveAM.html"
SRC_URI="ftp://ftp.common-lisp.net/pub/project/bese/fiveam_${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc"
DEPEND="dev-lisp/cl-arnesi
	doc? ( virtual/tetex )"

CLPACKAGE="fiveam"

S=${WORKDIR}/fiveam_${PV}

src_unpack() {
	unpack ${A}
	find ${S}/ -type d -name .arch-ids -exec rm -rf '{}' \; &>/dev/null
}

src_compile() {
	use doc && make -C docs || die
}

src_install() {
	dodir /usr/share/common-lisp/source/fiveam
	dodir /usr/share/common-lisp/systems
	cp -R src t ${D}/usr/share/common-lisp/source/fiveam/
	common-lisp-install fiveam.asd
	common-lisp-system-symlink
	dosym /usr/share/common-lisp/source/fiveam/fiveam.asd \
		/usr/share/common-lisp/systems/
	use doc && dodoc docs/FiveAM.pdf
}
