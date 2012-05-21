# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/icclib/icclib-2.13.ebuild,v 1.2 2012/05/21 14:32:30 mr_bones_ Exp $

EAPI=4

inherit base multilib

MY_P="${PN}_V${PV}"
DESCRIPTION="Library for reading and writing ICC color profile files"
HOMEPAGE="http://freecode.com/projects/icclib"
SRC_URI="http://www.argyllcms.com/${MY_P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}

ICCLIB_SOVERSION="0"

PATCHES=(
	"${FILESDIR}/${PN}-2.13-make.patch"
)

src_compile() {
	emake ICCLIB_SOVERSION=${ICCLIB_SOVERSION}
}

src_install() {
	mv -v libicc.so libicc.so.${ICCLIB_SOVERSION}
	dolib.so libicc.so.${ICCLIB_SOVERSION}
	dosym libicc.so.${ICCLIB_SOVERSION} /usr/$(get_libdir)/libicc.so
	dobin iccdump
	dodoc Readme.txt todo.txt log.txt

	insinto /usr/include
	doins icc*.h
}
