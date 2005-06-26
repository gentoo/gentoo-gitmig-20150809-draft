# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc/fpc-2.0.0.ebuild,v 1.4 2005/06/26 12:41:57 swegener Exp $

inherit eutils

MY_PV="2.0.0"
STABLE="2.0.0"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1 LGPL-2.1-FPC"
KEYWORDS="~ppc ~x86"
DESCRIPTION="Free Pascal Compiler"
HOMEPAGE="http://www.freepascal.org/"
IUSE=""
SRC_URI="mirror://sourceforge/freepascal/fpc-${MY_PV}.source.tar.gz
	 x86? ( mirror://sourceforge/freepascal/fpc-${MY_PV}.i386-linux.tar )
	 ppc? ( mirror://sourceforge/freepascal/fpc-${MY_PV}.powerpc-linux.tar )"
DEPEND="!dev-lang/fpc-bin"
RDEPEND="!dev-lang/fpc-bin"
S=${WORKDIR}/fpc

src_unpack() {
	unpack ${A} || die "Unpacking ${A} failed!"
	case ${ARCH} in
	x86)
		tar -xf binary.i386-linux.tar || die "Unpacking binary.i386-linux.tar failed!"
		tar -zxf base.i386-linux.tar.gz || die "Unpacking base.i386-linux.tar.gz failed!"
		;;
	ppc)
		tar -xf binary.powerpc-linux.tar || die "Unpacking binary.powerpc-linux.tar failed!"
		tar -zxf base.powerpc-linux.tar.gz || die "Unpacking base.powerpc-linux.tar.gz failed!"
		;;
	esac
}

set_pp() {
	case ${ARCH} in
	x86)
		FPCARCH=386
		;;
	ppc)
		FPCARCH=ppc
		;;
	esac

	case $1 in
		bootstrap) pp=${WORKDIR}/lib/fpc/${STABLE}/ppc${FPCARCH} ;;
		new) pp=${S}/compiler/ppc${FPCARCH} ;;
		*) die "set_pp: unknown argument: $1" ;;
	esac
}

src_compile() {
	local pp d

	# Using the bootstrap compiler.
	set_pp bootstrap
	emake -j1 compiler_cycle PP=${pp} \
		|| die "make compiler_cycle failed!"

	# Using the new compiler.
	set_compiler new

	# We cannot do this at once!
	for d in rtl packages fcl; do
		emake -j1 -C $d clean PP=${pp} || die "make -C $d clean failed!"
	done

	emake -j1 rtl packages_base_all fcl packages_extra_all PP=${pp} \
		|| die "make rtl packages_base_all fcl packages_extra_all failed!"

	emake -j1 utils PP=${pp} DATA2INC=${S}/utils/data2inc \
		|| die "make utils failed!"
}

src_install() {
	local pp
	set_pp new

	make compiler_install rtl_install fcl_install \
		packages_install utils_install man_install \
		PP=${pp} FPCMAKE=${S}/utils/fpcm/fpcmake \
		INSTALL_PREFIX=${D}usr INSTALL_MANDIR=${D}usr/share/man \
		|| die "make install failed!"
}

pkg_preinst() {
	${IMAGE}/usr/lib/fpc/${MY_PV}/samplecfg /usr/lib/fpc/${MY_PV} ${IMAGE}/etc
	case ${ARCH} in
	x86)
		FPCARCH=386
		;;
	ppc)
		FPCARCH=ppc
		;;
	esac
	ln -s ../lib/fpc/${MY_PV}/ppc${FPCARCH} ${IMAGE}/usr/bin/
}

pkg_postinst() {
	# Using ewarn - it is really important for other ebuilds (e.g. Lazarus)
	if [ -e /etc/._cfg0000_fpc.cfg ]; then
		echo
		ewarn "Make sure you etc-update /etc/fpc.cfg"
		ewarn "Otherwise FPC will not work correctly."
		echo
		ebeep
	fi
	case ${ARCH} in
	x86)
		FPCARCH=386
		;;
	ppc)
		FPCARCH=ppc
		;;
	esac
	einfo "/usr/bin/ppc${FPCARCH} now points to the new binary:"
	einfo "			/usr/lib/${PN}/${MY_PV}/ppc${FPCARCH}"
}
