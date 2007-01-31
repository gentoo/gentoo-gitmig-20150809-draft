# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc/fpc-2.0.0-r1.ebuild,v 1.6 2007/01/31 14:31:05 genone Exp $

inherit eutils

MY_PV="2.0.0"
STABLE="2.0.0"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1 LGPL-2.1-FPC"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
DESCRIPTION="Free Pascal Compiler"
HOMEPAGE="http://www.freepascal.org/"
IUSE="doc"
SRC_URI="mirror://sourceforge/freepascal/fpc-${MY_PV}.source.tar.gz
	 x86? ( mirror://sourceforge/freepascal/fpc-${MY_PV}.i386-linux.tar )
	 sparc? ( mirror://sourceforge/freepascal/fpc-${MY_PV}.sparc-linux.tar )
	 ppc? ( mirror://sourceforge/freepascal/fpc-${MY_PV}.powerpc-linux.tar )
	 amd64? ( mirror://sourceforge/freepascal/fpc-${MY_PV}.x86_64-linux.tar )"
DEPEND="!dev-lang/fpc-bin
	doc? ( dev-tex/tex4ht )"
RDEPEND="!dev-lang/fpc-bin"
S=${WORKDIR}/fpc

src_unpack() {
	unpack ${A} || die "Unpacking ${A} failed!"
	case ${ARCH} in
	x86)
		tar -xf binary.i386-linux.tar || die "Unpacking binary.i386-linux.tar failed!"
		tar -zxf base.i386-linux.tar.gz || die "Unpacking base.i386-linux.tar.gz failed!"
		;;
	sparc)
		tar -xf binary.sparc-linux.tar || die "Unpacking binary.sparc-linux.tar
		failed!"
		tar -zxf base.sparc-linux.tar.gz || die "Unpacking
		base.sparc-linux.tar.gz failed!"
		;;
	ppc)
		tar -xf binary.powerpc-linux.tar || die "Unpacking binary.powerpc-linux.tar failed!"
		tar -zxf base.powerpc-linux.tar.gz || die "Unpacking base.powerpc-linux.tar.gz failed!"
		;;
	amd64)
		tar -xf binary.x86_64-linux.tar || die "Unpacking binary.x86_64-linux.tar failed!"
		tar -zxf base.x86_64-linux.tar.gz || die "Unpacking base.x86_64-linux.tar.gz failed!"
		;;
	esac
}

set_pp() {
	case ${ARCH} in
	x86)
		FPCARCH=386
		;;
	sparc)
		FPCARCH=sparc
		;;
	ppc)
		FPCARCH=ppc
		;;
	amd64)
		FPCARCH=x64
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
	set_pp new

	# We cannot do this at once!
	for d in rtl packages fcl; do
		emake -j1 -C $d clean PP=${pp} || die "make -C $d clean failed!"
	done

	emake -j1 rtl packages_base_all fcl packages_extra_all PP=${pp} \
		|| die "make rtl packages_base_all fcl packages_extra_all failed!"

	emake -j1 utils PP=${pp} DATA2INC=${S}/utils/data2inc \
		|| die "make utils failed!"

	cd ${S}/docs
	use doc && make 4ht
	# examples fail miserably in v.2.0.0, sent email upstream
	# use examples && make linuxexamples
}

src_install() {
	local pp
	set_pp new

	make compiler_install rtl_install fcl_install \
		packages_install utils_install man_install \
		PP="${pp}" FPCMAKE="${S}/utils/fpcm/fpcmake" \
		INSTALL_PREFIX="${D}usr" INSTALL_MANDIR="${D}usr/share/man" \
		doc_install INSTALL_DOCDIR="${D}usr/share/doc/${PF}/" \
		|| die "make install failed!"
	dohtml ${D}usr/share/doc/${PF}/faq.html
	rm ${D}usr/share/doc/${PF}/faq.html
	cd ${S}/docs
	use doc && make INSTALL_DOCDIR="${D}usr/share/doc/${PF}/html" htmlinstall
}

pkg_preinst() {
	${IMAGE}/usr/lib/fpc/${MY_PV}/samplecfg /usr/lib/fpc/${MY_PV} ${IMAGE}/etc
	case ${ARCH} in
	x86)
		FPCARCH=386
		;;
	sparc)
		FPCARCH=sparc
		;;
	ppc)
		FPCARCH=ppc
		;;
	amd64)
		FPCARCH=x64
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
	sparc)
		FPCARCH=sparc
		;;
	ppc)
		FPCARCH=ppc
		;;
	amd64)
		FPCARCH=x64
		;;
	esac
	elog "/usr/bin/ppc${FPCARCH} now points to the new binary:"
	elog "			/usr/lib/${PN}/${MY_PV}/ppc${FPCARCH}"
}
