# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/fasta/fasta-35.4.10.ebuild,v 1.7 2011/01/18 17:03:34 tomka Exp $

EAPI="2"

inherit eutils flag-o-matic toolchain-funcs

DESCRIPTION="FASTA is a DNA and Protein sequence alignment software package"
HOMEPAGE="http://fasta.bioch.virginia.edu/fasta_www2/fasta_down.shtml"
SRC_URI="http://faculty.virginia.edu/wrpearson/${PN}/${PN}3/${P}.tar.gz"

LICENSE="fasta"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~amd64-linux ~x86-linux"
IUSE="debug icc sse2 test"

DEPEND="
	icc? ( dev-lang/icc )
	test? ( app-shells/tcsh )"
RDEPEND=""

pkg_setup() {
	if use icc; then
		elog "Please make your CFLAGS are supported by icc"
		elog "Either make sure they are set in /etc/make.conf"
		elog "or run"
		elog "env CFLAGS="..." emerge fasta"
		epause 5
	fi
}

src_prepare() {
	CC_ALT=
	CFLAGS_ALT=
	ALT=

	use debug && append-flags -DDEBUG

	if use icc ; then
		CC_ALT=icc
		ALT="${ALT}_icc"
	else
		CC_ALT=$(tc-getCC)
		use x86 && ALT="32"
		use amd64 && ALT="64"
	fi

	if use sse2 ; then
		ALT="${ALT}_sse2"
		append-flags -msse2
		use icc || append-flags -ffast-math
	fi

	export CC_ALT="${CC_ALT}"
	export ALT="${ALT}"

	epatch "${FILESDIR}"/${PV}-ldflags.patch
}

src_compile() {
	cd src
	emake -f ../make/Makefile.linux${ALT} CC="${CC_ALT} ${CFLAGS}" HFLAGS="${LDFLAGS} -o" all || die
}

src_install() {
	dobin bin/* || die
	doman doc/{prss3.1,fasta35.1,pvcomp.1,fasts3.1,fastf3.1,ps_lav.1,map_db.1} || die
	dodoc  FASTA_LIST README doc/{README.versions,readme*,fasta*,changes*} || die
}
