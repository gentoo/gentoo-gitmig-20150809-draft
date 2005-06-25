# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc/fpc-2.0.0.ebuild,v 1.1 2005/06/25 22:26:32 agriffis Exp $

inherit eutils

MY_PV="2.0.0"
STABLE="2.0.0"
ARCH="386"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1 LGPL-2.1-FPC"
KEYWORDS="~x86"
DESCRIPTION="Free Pascal Compiler"
HOMEPAGE="http://www.freepascal.org/"
IUSE=""
SRC_URI="mirror://sourceforge/freepascal/fpc-${MY_PV}.source.tar.gz
	 mirror://sourceforge/freepascal/fpc-${MY_PV}.i386-linux.tar"
DEPEND="!dev-lang/fpc-bin"
RDEPEND="!dev-lang/fpc-bin"
S=${WORKDIR}/fpc

src_unpack() {
	unpack ${A} || die "Unpacking ${A} failed!"
	tar -xf binary.i386-linux.tar || die "Unpacking binary.i386-linux.tar failed!"
	tar -zxf base.i386-linux.tar.gz || die "Unpacking base.i386-linux.tar.gz failed!"
}

set_pp() {
	case $1 in
		bootstrap) pp=${WORKDIR}/lib/fpc/${STABLE}/ppc${ARCH} ;;
		new) pp=${S}/compiler/ppc${ARCH} ;;
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

	make compiler_install rtl_install fcl_install packages_install utils_install \
		PP=${pp} FPCMAKE=${S}/utils/fpcm/fpcmake INSTALL_PREFIX=${D}usr \
		|| die "make install failed!"
}

pkg_preinst() {
	${IMAGE}/usr/lib/fpc/${MY_PV}/samplecfg /usr/lib/fpc/${MY_PV} ${IMAGE}/etc
	ln -s ../lib/fpc/${MY_PV}/ppc386 ${IMAGE}/usr/bin/
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
	einfo "/usr/bin/ppc386 now points to the new binary:"
	einfo "			/usr/lib/${PN}/${MY_PV}/ppc${ARCH}"
}
