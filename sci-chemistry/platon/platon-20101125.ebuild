# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/platon/platon-20101125.ebuild,v 1.1 2010/11/25 19:10:36 jlec Exp $

EAPI="3"

inherit eutils flag-o-matic fortran multilib toolchain-funcs

FORTRAN="g77 gfortran"

DESCRIPTION="Versatile, SHELX-97 compatible, multipurpose crystallographic tool"
HOMEPAGE="http://www.cryst.chem.uu.nl/platon/"
SRC_URI="${P}.tar.gz"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="examples"

# Can't do libf2c dependent on whether <gcc-4 is selected for the build,
# so we must always require it
RDEPEND="x11-libs/libX11"
DEPEND="${RDEPEND}"

RESTRICT="fetch"

S="${WORKDIR}/${PN}"

pkg_nofetch() {
	elog "Download ${A/-${PV}} from ftp://xraysoft.chem.uu.nl/pub/unix/,"
	elog "rename it to ${A} and place it"
	elog "in ${DISTDIR}."
	elog "If there is a digest mismatch, please file a bug"
	elog "at https://bugs.gentoo.org/ -- a version bump"
	elog "is probably required."
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	gunzip platon.f.gz xdrvr.c.gz || die
}

src_prepare() {
	epatch "${FILESDIR}"/${PV}-buffer-overflow.patch
}

src_compile() {
	# easy to ICE, at least on gcc 4.3
	strip-flags

	COMMAND="$(tc-getCC) -c ${CFLAGS} xdrvr.c"
	echo ${COMMAND}
	${COMMAND} || die "Compilation of xdrvr.c failed"
	COMMAND="${FORTRANC} -c ${FFLAGS:- -O2} -fno-second-underscore platon.f"
	echo ${COMMAND}
	${COMMAND} || die "Compilation of platon.f failed"
	COMMAND="${FORTRANC} -o platon ${LDFLAGS} platon.o xdrvr.o -lX11 ${F2C}"
	echo ${COMMAND}
	${COMMAND} || die "Linking failed"
}

src_install() {
	dobin platon || die

	for bin in pluton s cifchk helena stidy; do
		dosym platon /usr/bin/${bin} || die
	done

	insinto /usr/$(get_libdir)/platon
	doins check.def || die

	echo "CHECKDEF=\"${EPREFIX}/usr/$(get_libdir)/platon/check.def\"" > "${T}"/env.d
	newenvd "${T}"/env.d 50platon || die

	dodoc README.* || die

	if use examples; then
		insinto /usr/share/${PN}
		doins -r TEST || die
	fi
}
