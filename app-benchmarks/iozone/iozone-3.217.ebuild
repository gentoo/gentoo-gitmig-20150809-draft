# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-benchmarks/iozone/iozone-3.217.ebuild,v 1.5 2004/10/05 11:08:30 pvdabeel Exp $

inherit eutils

DESCRIPTION="Filesystem benchmarking program."
HOMEPAGE="http://www.iozone.org/"
SRC_URI="http://www.iozone.org/src/current/${PN}${PV/./_}.tar"
LICENSE="freedist"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="sys-devel/gcc"

S=${WORKDIR}

src_compile() {

	case ${ARCH} in
		x86|alpha)
			PLATFORM="linux"
			;;
		ppc)
			PLATFORM="linux-powerpc"
			;;
		*)
			PLATFORM="linux-${ARCH}"
			;;
	esac

	cd src/current
	emake ${PLATFORM} || die "Compile failed"
}

src_install() {
	dosbin src/current/iozone
	dodoc docs/IO*
	dodoc docs/Run_rules.doc
	dodoc src/current/Changes.txt
	doman docs/iozone.1

	dodir /usr/share/${PF}
	insinto /usr/share/${PF}
	cd src/current
	doins Generate_Graphs Gnuplot.txt gengnuplot.sh gnu3d.dem

	prepall
}
