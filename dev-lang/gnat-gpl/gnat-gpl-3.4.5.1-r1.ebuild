# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/gnat-gpl/gnat-gpl-3.4.5.1-r1.ebuild,v 1.3 2007/02/06 08:11:12 genone Exp $

inherit gnatbuild flag-o-matic

DESCRIPTION="GNAT Ada Compiler - AdaCore GPL version"
HOMEPAGE="https://libre2.adacore.com/"
LICENSE="GPL-2"

SRC_URI="ftp://gcc.gnu.org/pub/gcc/releases/gcc-${GCCVER}/gcc-core-${GCCVER}.tar.bz2
	http://www.adaic.org/standards/05rm/RM-05-Html.zip
	http://dev.gentoo.org/~george/src/${P}-src.tar.bz2
	x86?   ( http://dev.gentoo.org/~george/src/gnatboot-3.4-i686-r1.tar.bz2 )
	amd64? ( http://dev.gentoo.org/~george/src/gnatboot-3.4-amd64-r1.tar.bz2 )"
# ${GNATBRANCH} and ${GCCVER} are defined in gnatbuild.eclass and depend 
# only on $PV, so should be safe to use in DEPEND/SRC_URI

KEYWORDS="~amd64 ~x86"
DEPEND="app-arch/unzip"
RDEPEND=""

GNATSOURCE="${WORKDIR}/${P}-src"

src_unpack() {
	gnatbuild_src_unpack base_unpack

	# prep gcc sources for Ada
	mv "${GNATSOURCE}/src/ada" "${S}/gcc"
	cd "${S}"
	patch -p0 < "${GNATSOURCE}/src/gcc-34.dif"

	gnatbuild_src_unpack common_prep

	# one of the converted gcc->gnatgcc in common_prep needs to stay gcc in
	# fact in this version
	sed -i -e 's:(Last3 = "gnatgcc"):(Last3 = "gcc"):' "${S}/gcc/ada/makegpr.adb"
}

src_install() {
	gnatbuild_src_install install

	# there is something strange with provided Makefiles, causing an
	# access violation on gprmake. Have to do funny things..
	make DESTDIR=${D} bindir="${D}${BINPATH}"  install || die
	mv "${D}${D}${PREFIX}/${CTARGET}" "${D}${PREFIX}"
	rm -rf "${D}var"

	gnatbuild_src_install move_libs cleanup prep_env

	# docs have to be fetched from 3rd place, quite messy package
	dodir /usr/share/doc/${PF}/html
	dohtml "${WORKDIR}"/*.html

	# misc notes and examples
	cd ${GNATSOURCE}
	dodoc COPYING README features-503 features-ada0y known-problems-503a
	cp -pPR examples/ "${D}/usr/share/doc/${PF}/"
}

pkg_postinst() {
	gnatbuild_pkg_postinst

	elog
	elog "This is an experimental issue of the gnat-gpl compiler, supporting"
	elog "some of the new features of Ada2005. You may consider registering with"
	elog "AdaCore at https://libre2.adacore.com/."
	elog
	ewarn "Please note!!!"
	ewarn "gnat-gpl is distributed under the GPL-2 license, without the GMGPL provision!!"
	ewarn "For the GMGPL version you may look at the gnat-gcc compiler."
	ewarn
}
