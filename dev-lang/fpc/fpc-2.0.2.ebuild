# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc/fpc-2.0.2.ebuild,v 1.2 2006/04/19 19:33:35 carlo Exp $

inherit eutils


PV_BIN="2.0.0"
S="${WORKDIR}/fpc"

HOMEPAGE="http://www.freepascal.org/"
DESCRIPTION="Free Pascal Compiler"
SRC_URI="mirror://sourceforge/freepascal/fpc-${PV}.source.tar.gz
	mirror://gentoo/fpc-man-${PV}.tar.gz
	x86? ( mirror://gentoo/fpc-${PV_BIN}.i386-linux.tar )
	sparc? ( mirror://gentoo/fpc-${PV_BIN}.sparc-linux.tar )
	ppc? ( mirror://gentoo/fpc-${PV_BIN}.powerpc-linux.tar )
	amd64? ( mirror://gentoo/fpc-${PV_BIN}.x86_64-linux.tar )
	doc? ( mirror://gentoo/fpc-docs-${PV}.tar.gz )"

SLOT="0"
LICENSE="GPL-2 LGPL-2.1 LGPL-2.1-FPC"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc source"

DEPEND="!dev-lang/fpc-bin
	!dev-lang/fpc-source
	net-misc/rsync"
RDEPEND="!dev-lang/fpc-bin
	!dev-lang/fpc-source"

src_unpack() {
	unpack ${A} || die "Unpacking ${A} failed!"
	case ${ARCH} in
		x86)	FPC_ARCH="i386" ;;
		ppc)	FPC_ARCH="powerpc" ;;
		amd64)	FPC_ARCH="x86_64" ;;
		sparc)	FPC_ARCH="sparc" ;;
		*) die "This ebuild doesn't support ${ARCH}." ;;
	esac
	tar -xf binary.${FPC_ARCH}-linux.tar || die "Unpacking binary.${FPC_ARCH}-linux.tar failed!"
	tar -zxf base.${FPC_ARCH}-linux.tar.gz || die "Unpacking base.${FPC_ARCH}-linux.tar.gz failed!"
}

set_pp() {
	case ${ARCH} in
		x86)	FPC_ARCH="386" ;;
		ppc)	FPC_ARCH="ppc" ;;
		amd64)	FPC_ARCH="x64" ;;
		sparc)	FPC_ARCH="sparc" ;;
		*) die "This ebuild doesn't support ${ARCH}." ;;
	esac

	case ${1} in
		bootstrap) pp=${WORKDIR}/lib/fpc/${PV_BIN}/ppc${FPC_ARCH} ;;
		new) 	pp=${S}/compiler/ppc${FPC_ARCH} ;;
		*) die "set_pp: unknown argument: ${1}" ;;
	esac
}

src_compile() {
	local pp d

	# Using the bootstrap compiler.
	set_pp bootstrap
	make -j1 compiler_cycle PP=${pp} || die "make compiler_cycle failed!"

	# Save new compiler from cleaning...
	cp ${S}/compiler/ppc${FPC_ARCH} ${S}/ppc${FPC_ARCH}.new
	# ...rebuild with current version...
	make -j1 compiler_cycle PP=${S}/ppc${FPC_ARCH}.new || die "make compiler_cycle failed!"
	# ..and clean up afterwards
	rm ${S}/ppc${FPC_ARCH}.new

	# Using the new compiler.
	set_pp new

	# We cannot do this at once!
	for d in rtl packages fcl; do
		make -j1 -C $d clean PP=${pp} || die "make -C $d clean failed!"
	done

	make -j1 rtl packages_base_all fcl packages_extra_all PP=${pp} \
		|| die "make rtl packages_base_all fcl packages_extra_all failed!"

	make -j1 utils PP=${pp} DATA2INC=${S}/utils/data2inc \
		|| die "make utils failed!"
}

src_install() {
	local pp
	set_pp new

	make compiler_install rtl_install fcl_install \
		packages_install utils_install \
		PP="${pp}" FPCMAKE="${S}/utils/fpcm/fpcmake" \
		INSTALL_PREFIX="${D}usr" || die "make install failed!"

	find ${WORKDIR}/fpc/ -type f -perm -o=x -exec rm '{}' \;
	if use "source" ; then
		ebegin "Copying source files"
	        # Use rsync since cp doesn't support exclusions
		rsync -a \
		--exclude="*.#*" \
		--exclude="*.bak" \
		--exclude="*.cvsignore" \
		--exclude="*.o" \
		--exclude="*.orig" \
		--exclude="*.ow" \
		--exclude="*.ppl" \
		--exclude="*.ppu" \
		--exclude="*.ppw" \
		--exclude="*.rej" \
		--exclude="*.rst" \
		--exclude="*.xvpics" \
		--exclude="*.~*" \
		--exclude="CVS" \
		--exclude=".svn" \
		--exclude="fpcmade.i386-linux" \
		${WORKDIR}/fpc/ ${D}usr/lib/fpc/src
		eend $? || die
	fi

	if use doc ; then
		insinto	/usr/share/doc/${PF}
		doins	${WORKDIR}/fpc-docs-${PV}/*.pdf
	fi

	doman ${WORKDIR}/fpc-man-${PV}/man{1,5}/*
}

pkg_preinst() {
	${IMAGE}/usr/lib/fpc/${PV}/samplecfg /usr/lib/fpc/${PV} ${IMAGE}/etc
	case ${ARCH} in
		x86)	FPC_ARCH="386" ;;
		ppc)	FPC_ARCH="ppc" ;;
		amd64)	FPC_ARCH="x64" ;;
		sparc)	FPC_ARCH="sparc" ;;
		*) die "This ebuild doesn't support ${ARCH}." ;;
	esac
	ln -s ../lib/fpc/${PV}/ppc${FPC_ARCH} ${IMAGE}/usr/bin/
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
		x86)	FPC_ARCH="386" ;;
		ppc)	FPC_ARCH="ppc" ;;
		amd64)	FPC_ARCH="x64" ;;
		sparc)	FPC_ARCH="sparc" ;;
		*) die "This ebuild doesn't support ${ARCH}." ;;
	esac
	einfo "/usr/bin/ppc${FPC_ARCH} now points to the new binary:"
	einfo "			/usr/lib/${PN}/${PV}/ppc${FPC_ARCH}"
}
