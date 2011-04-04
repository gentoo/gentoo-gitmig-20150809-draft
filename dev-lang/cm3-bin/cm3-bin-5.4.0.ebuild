# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/cm3-bin/cm3-bin-5.4.0.ebuild,v 1.5 2011/04/04 15:27:22 ulm Exp $

inherit toolchain-funcs eutils

if [[ ${PV} == *_pre* ]] ; then
	STAMP=${PV/*_pre}
	MY_PV=d${PV/_pre*}-20${STAMP:0:2}-${STAMP:2:2}-${STAMP:4:2}
else
	MY_PV=${PV}
fi
DESCRIPTION="Critical Mass Modula-3 compiler (binary version)"
HOMEPAGE="http://www.elegosoft.com/cm3/"
SRC_URI="x86? ( http://www.elegosoft.com/cm3/cm3-min-POSIX-LINUXLIBC6-${MY_PV}.tgz )
	amd64? ( http://www.elegosoft.com/cm3/cm3-min-POSIX-LINUXLIBC6-${MY_PV}.tgz )"

LICENSE="CMASS-M3 DEC-M3"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""
RESTRICT="strip"

DEPEND=""
RDEPEND="app-editors/gentoo-editor"

S=${WORKDIR}

QA_TEXTRELS="usr/lib32/cm3/pkg/libm3/LINUXLIBC6/libm3.so.5
	usr/lib32/cm3/pkg/m3core/LINUXLIBC6/libm3core.so.5"
QA_EXECSTACK="usr/lib32/cm3/bin/cm3
	usr/lib32/cm3/pkg/m3core/LINUXLIBC6/libm3core.so.5"

src_unpack() {
	unpack ${A}
	unpack ./system.tgz
	cd "${S}"
	epatch "${FILESDIR}"/${P}-cm3-cfg.patch
	sed -i \
		-e "s:@GENTOO_INITIAL_REACTOR_EDITOR@:/usr/libexec/gentoo-editor:" \
		-e "s:@GENTOO_INSTALL_ROOT@:/usr/$(get_libdir)/cm3/:" \
		-e "s:@GENTOO_CC@:$(tc-getCC):" \
		-e "s:@GENTOO_AR@:$(tc-getAR):" \
		-e "s:@GENTOO_AS@:$(tc-getAS):" \
		bin/cm3.cfg
	if [[ -e pkg/m3core/LINUXLIBC6 ]] ; then
		cd pkg/m3core/LINUXLIBC6
		rm -f libm3core.so
		ln -s libm3core.so.5 libm3core.so || die
		cd "${S}"
	fi
	if [[ -e pkg/libm3/LINUXLIBC6 ]] ; then
		cd pkg/libm3/LINUXLIBC6
		rm -f libm3.so
		ln -s libm3.so.5 libm3.so || die
		cd "${S}"
	fi
}

src_install() {
	use amd64 && export ABI=x86
	local libdir="/usr/$(get_libdir)/cm3"
	dodir ${libdir}
	cp -a pkg bin lib "${D}"${libdir}/ || die "mv lib"
	dobin "${FILESDIR}"/m3{build,ship}
	make_wrapper cm3 ./cm3 ${libdir}/bin ${libdir}/lib
	make_wrapper cm3cg ./cm3cg ${libdir}/bin ${libdir}/lib
}
