# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/mammoth/mammoth-1.0.ebuild,v 1.2 2010/09/13 12:43:53 hwoarang Exp $

inherit autotools eutils fortran

MY_P="${P}-src"

DESCRIPTION="MAtching Molecular Models Obtained from THeory"
HOMEPAGE="http://ub.cbm.uam.es/software.php"
SRC_URI="${MY_P}.tgz"
LICENSE="mammoth"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="fetch"
RDEPEND=""
DEPEND="${RDEPEND}"
S=${WORKDIR}/${MY_P}
FORTRAN="gfortran g77"

pkg_nofetch() {
	einfo "Download the source code for MAMMOTH from"
	einfo "${HOMEPAGE}"
	einfo "and place it in ${DISTDIR}"
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Broken with gfortran without this patch
	epatch "${FILESDIR}"/${PV}-consistent-system-intrinsic.patch

	case ${FORTRANC} in
		g77)		append-fflags -ffixed-line-length-none ;;
		gfortran)	append-fflags -ffixed-line-length-none ;;
	esac

	# It comes with a custom-modified configure for some reason,
	# which forces you to pass in the Fortran compiler as a parameter.
	# Let's do the standard stuff instead.
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS || die
}

append-fflags() {
	[[ -z $* ]] && return 0
	export FFLAGS="${FFLAGS} $*"
	return 0
}
