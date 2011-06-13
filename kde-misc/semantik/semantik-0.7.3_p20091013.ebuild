# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/semantik/semantik-0.7.3_p20091013.ebuild,v 1.2 2011/06/13 21:55:15 dilfridge Exp $

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
	x11-libs/qt-core
	x11-libs/qt-gui
	x11-libs/qt-xmlpatterns
	dev-lang/python[xml]
"

S="${WORKDIR}/semantik-0.7.4"
WAF_BINARY="${S}/waf"

PATCHES=( "${FILESDIR}/${P}"-wscript_ldconfig.patch )

src_configure() {
	CCFLAGS="${CFLAGS}" LINKFLAGS="${LDFLAGS}" "${WAF_BINARY}" \
		"--prefix=${EPREFIX}/usr" --want-rpath=0 \
		configure || die "configure failed"
}
