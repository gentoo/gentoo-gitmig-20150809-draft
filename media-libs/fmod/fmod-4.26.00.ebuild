# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/fmod/fmod-4.26.00.ebuild,v 1.3 2009/11/25 14:26:31 maekke Exp $

inherit versionator

MY_P=fmodapi$(delete_all_version_separators)linux

DESCRIPTION="music and sound effects library, and a sound processing system"
HOMEPAGE="http://www.fmod.org"
SRC_URI="x86? ( http://www.fmod.org/index.php/release/version/${MY_P}.tar.gz )
	amd64? ( http://www.fmod.org/index.php/release/version/${MY_P}64.tar.gz )"

LICENSE="fmod"
SLOT="1"
KEYWORDS="amd64 x86"
IUSE="examples"

RDEPEND=""
DEPEND=""

RESTRICT="strip test"

QA_TEXTRELS="opt/fmodex/fmoddesignerapi/api/lib/*
opt/fmodex/api/lib/*
opt/fmodex/api/plugins/*"

src_compile() { :; }
src_install() {
	dodir /opt/fmodex

	local fbits=""
	use amd64 && fbits="64"

	local fsource="${WORKDIR}/${MY_P}${fbits}"

	cd "${fsource}"/api/lib

	cp -f libfmodex${fbits}-${PV}.so libfmodex.so.${PV} || die
	cp -f libfmodexp${fbits}-${PV}.so libfmodexp.so.${PV} || die
	cp -f libfmodex${fbits}L-${PV}.so libfmodexL.so.${PV} || die

	ln -sf libfmodex.so.${PV} libfmodex.so || die
	ln -sf libfmodex.so.${PV} libfmodex.so.4 || die
	ln -sf libfmodexp.so.${PV} libfmodexp.so || die
	ln -sf libfmodexp.so.${PV} libfmodexp.so.4 || die
	ln -sf libfmodexL.so.${PV} libfmodexL.so || die
	ln -sf libfmodexL.so.${PV} libfmodexL.so.4 || die

	cp -dpR "${fsource}"/* "${D}"/opt/fmodex || die

	dosym /opt/fmodex/api/inc /usr/include/fmodex || die

	use examples || rm -rf "${D}"/opt/fmodex/{,fmoddesignerapi}/examples

	insinto /usr/share/doc/${PF}/pdf
	doins "${fsource}"/documentation/*.pdf
	dodoc "${fsource}"/{documentation/*.txt,fmoddesignerapi/*.TXT}
	rm -rf "${D}"/opt/fmodex/{documentation,fmoddesignerapi/*.TXT}

	echo LDPATH="/opt/fmodex/api/lib" > "${T}"/65fmodex
	doenvd "${T}"/65fmodex
}
