# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/xdelta/xdelta-3.0t.ebuild,v 1.2 2009/06/29 19:41:36 jer Exp $

inherit distutils

MY_P=${PN}${PV}

DESCRIPTION="a binary diff and differential compression tools. VCDIFF (RFC 3284) delta compression."
HOMEPAGE="http://xdelta.org"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="dev-lang/python"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_P}

DOCS="draft-korn-vcdiff.txt"

pkg_setup() {
	if use alpha || use amd64 || use ia64 || use ppc64 || use sparc; then
		xdelta="xdelta3-64"
	else
		xdelta="xdelta3"
	fi
}

src_compile() {
	distutils_src_compile
	emake ${xdelta} || die "emake ${xdelta} failed."
}

src_install() {
	distutils_src_install
	dobin ${xdelta} || die "dobin ${xdelta} failed."
	[[ $xdelta = xdelta3-64 ]] && dosym ${xdelta} /usr/bin/xdelta3
}
