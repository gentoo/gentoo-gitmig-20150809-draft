# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-icu/cl-icu-0.0_p11.ebuild,v 1.2 2005/03/21 08:14:13 mkennedy Exp $

inherit common-lisp eutils

MY_P=${PN}--dev--${PV/_*/}--patch-${PV/*_p/}

DESCRIPTION="CL-ICU is a common lisp interface to IBM's ICU library."
HOMEPAGE="http://common-lisp.net/project/bese/cl-icu.html"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

# ICU is not binary compatible between *minor* version releases because they
# suffix all the symbols with a version string!

DEPEND="dev-lisp/cl-uffi
	dev-lisp/cl-arnesi
	=dev-libs/icu-3.2*"

CLPACKAGE=cl-icu

S=${WORKDIR}/${MY_P}

pkg_setup() {
	local version=$(icu-config --version)
	if [ "${version:0:3}" != "3.2" ]; then
		warn "Note: dev-lisp/cl-icu when used against versions other than ICU 3.2 may not work."
	fi
}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
	find ${S}/ -type d -name .arch-ids -exec rm -rf '{}' \; &>/dev/null

}

src_install() {
	dodir /usr/share/common-lisp/source/cl-icu
	dodir /usr/share/common-lisp/systems
	insinto /usr/share/common-lisp/source/cl-icu/
	doins -r src
	common-lisp-install cl-icu.asd
	common-lisp-system-symlink
	dosym /usr/share/common-lisp/source/cl-icu/cl-icu.asd \
		/usr/share/common-lisp/systems/
	dodoc README
}
