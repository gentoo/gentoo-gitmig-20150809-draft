# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc/fpc-2.0.0_rc2.ebuild,v 1.2 2005/03/31 01:55:54 chriswhite Exp $

inherit eutils

MY_P="1.9.8"
STABLE="1.0.10"
ARCH="386"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1 LGPL-2.1-FPC"
KEYWORDS="~x86"
DESCRIPTION="Free Pascal Compiler"
HOMEPAGE="http://www.freepascal.org/"
IUSE=""
SRC_URI="ftp://ftp.freepascal.org/pub/fpc/beta/source-${MY_P}/fpc-${MY_P}.source.tar.gz
	 ftp://ftp.freepascal.org/pub/fpc/dist/Linux/i386/separate/binary.tar"
DEPEND="!dev-lang/fpc-bin"
RDEPEND="!dev-lang/fpc-bin"
S=${WORKDIR}/fpc

src_unpack () {
	unpack ${A} || die "Unpacking ${A} failed!"
	tar -zxf baselinux.tar.gz || die "Unpacking baselinux.tar.gz failed!"
}

src_compile () {
	# Using the bootstrap compiler.
	COMPILER=${WORKDIR}/lib/fpc/${STABLE}/ppc${ARCH}
	emake -j1 \
		compiler_cycle \
	PP=${COMPILER} \
		|| die "make compiler_cycle failed!"

	# Using the new compiler.
	COMPILER=${S}/compiler/ppc${ARCH}

	# We cannot do this at once!
	clean_subdir "rtl"
	clean_subdir "packages"
	clean_subdir "fcl"

	emake -j1 \
		rtl \
		packages_base_all \
		fcl \
		packages_extra_all \
	PP=${COMPILER} \
	|| die "make rtl packages_base_all fcl packages_extra_all failed!"

	DATA2INC=${S}/utils/data2inc
	emake -j1 \
	utils \
	PP=${COMPILER} \
	DATA2INC=${DATA2INC} \
	|| die "make utils failed!"
}

src_install () {
	FPCMAKE=${S}/utils/fpcm/fpcmake
	emake -j1 \
		compiler_install \
		rtl_install \
		fcl_install \
		packages_install \
		utils_install \
	PP=${COMPILER} \
	FPCMAKE=${FPCMAKE} \
	INSTALL_PREFIX=${D}usr \
	|| die "make compiler_install rtl_install fcl_install packages_install utils_install failed!"
}

pkg_preinst () {
	${D}usr/lib/fpc/${MY_P}/samplecfg /usr/lib/fpc/${MY_P} ${D}etc
	ln -s ../lib/fpc/${MY_P}/ppc386 ${D}usr/bin/
}

pkg_postinst () {
	# Using ewarn - it is really important for other ebuilds.
	if [ -e /etc/._cfg0000_fpc.cfg ]; then
		ewarn
		ewarn "Make sure you update /etc/fpc.cfg !"
		ewarn "Otherwise FPC will not work correctly."
		ewarn
		ebeep
	fi
	einfo "/usr/bin/ppc386 now points to the new binary."
	echo $D
}

clean_subdir() {
	emake -j1 \
	-C $1 \
	clean \
	PP=${COMPILER} \
	|| die "make -C $1 clean failed!"
}
