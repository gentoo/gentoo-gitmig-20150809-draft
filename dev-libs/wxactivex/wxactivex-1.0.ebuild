# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/wxactivex/wxactivex-1.0.ebuild,v 1.2 2006/03/19 22:38:05 halcy0n Exp $

inherit eutils

DESCRIPTION="wxActiveX is a wxWidgets ActiveX extension for the xmingw cross-compiler"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}.zip"
HOMEPAGE="http://sourceforge.net/projects/${PN}"

SLOT="0"
KEYWORDS="~x86"
IUSE=""
LICENSE="BSD"
RDEPEND=">=dev-libs/wx-xmingw-2.4.2"
DEPEND="${RDEPEND}
	app-arch/unzip"
S="${WORKDIR}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-1.0-gentoo.patch
}

src_compile() {
	export PATH="/opt/xmingw/bin:/opt/xmingw/i386-mingw32msvc/bin:/opt/xmingw/wxWidgets/bin:$PATH"
	export CC="i386-mingw32msvc-gcc"
	export CXX="i386-mingw32msvc-g++"

	unset CFLAGS
	unset CPPFLAGS
	unset CXXFLAGS
	unset LDFLAGS

	export CFLAGS="-I/opt/xmingw/i386-mingw32msvc/include"
	export CXXFLAGS="-I/opt/xmingw/i386-mingw32msvc/include"


	emake CC=${CXX} || die "make failed"
}

src_install() {
	cd ${WORKDIR}
	make prefix=${D}/opt/xmingw/wxActiveX install || die "install failed"
}

