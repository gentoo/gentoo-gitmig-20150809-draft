# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/semantik/semantik-0.7.3_p20091013.ebuild,v 1.4 2012/07/15 15:21:50 kensington Exp $

EAPI=4

inherit kde4-base waf-utils

DESCRIPTION="Mindmapping-like tool for document generation."
HOMEPAGE="http://freehackers.org/~tnagy/semantik.html"
SRC_URI="http://semantik.googlecode.com/files/semantik-snapshot.tar.bz2 -> ${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	dev-lang/ocaml
	dev-lang/python
"
RDEPEND="
	x11-libs/qt-core:4
	x11-libs/qt-gui:4
	x11-libs/qt-xmlpatterns:4
	dev-lang/python[xml]
"

S="${WORKDIR}/semantik-0.7.4"
WAF_BINARY="${S}/waf"

PATCHES=(
	"${FILESDIR}/${P}"-wscript_ldconfig.patch
	"${FILESDIR}/${P}"-wscript_libstr.patch
)

src_configure() {
	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" "${WAF_BINARY}" \
		"--prefix=${EPREFIX}/usr" --want-rpath=0 \
		configure || die "configure failed"
}
