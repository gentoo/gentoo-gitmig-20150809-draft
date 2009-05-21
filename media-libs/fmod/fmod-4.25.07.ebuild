# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fmod/fmod-4.25.07.ebuild,v 1.2 2009/05/21 22:29:05 ssuominen Exp $

inherit versionator

MY_P=fmodapi$(delete_all_version_separators)linux

DESCRIPTION="music and sound effects library, and a sound processing system"
HOMEPAGE="http://www.fmod.org"
SRC_URI="x86? ( http://www.fmod.org/index.php/release/version/${MY_P}.tar.gz )
	amd64? ( http://www.fmod.org/index.php/release/version/${MY_P}64.tar.gz )"

LICENSE="fmod"
SLOT="1"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND=""

RESTRICT="strip test"

if use amd64; then
	S=${WORKDIR}/${MY_P}64
else
	S=${WORKDIR}/${MY_P}
fi

src_compile() { :; }

src_install() {
		dodir /opt/${MY_P}

		cd "${S}"/api/lib

		if use amd64; then
			cp -f libfmodex64-${PV}.so libfmodex.so.${PV}
			cp -f libfmodexp64-${PV}.so libfmodexp.so.${PV}
		fi
		if use x86; then
			cp -f libfmodex-${PV}.so libfmodex.so.${PV}
			cp -f libfmodexp-${PV}.so libfmodexp.so.${PV}
		fi

		ln -sf libfmodex.so.${PV} libfmodex.so
		ln -sf libfmodex.so.${PV} libfmodex.so.4
		ln -sf libfmodexp.so.${PV} libfmodexp.so
		ln -sf libfmodexp.so.${PV} libfmodexp.so.4

		cp -dpR "${S}"/* "${D}"/opt/${MY_P}

		dosym /opt/${MY_P}/api/inc /usr/include/fmodex

		insinto /usr/share/doc/${PF}
		doins "${S}"/documentation/*.pdf
		dodoc "${S}"/documentation/*.txt

		rm -rf "${D}"/opt/${MY_P}/documentation

		echo LDPATH="/opt/${MY_P}/api/lib" > "${T}"/65${MY_P}
		doenvd "${T}"/65${MY_P}
}
