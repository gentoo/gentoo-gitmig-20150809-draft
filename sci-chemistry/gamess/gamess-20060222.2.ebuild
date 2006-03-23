# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/gamess/gamess-20060222.2.ebuild,v 1.1 2006/03/23 15:02:36 markusle Exp $

inherit eutils toolchain-funcs fortran flag-o-matic

DESCRIPTION="A powerful quantum chemistry package"
LICENSE="gamess"
HOMEPAGE="http://www.msg.ameslab.gov/GAMESS/GAMESS.html"
SRC_URI="${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86"
IUSE="ifc hardened blas"

RESTRICT="fetch"

DEPEND="app-shells/tcsh
	ifc? ( >=dev-lang/ifc-8.1 )
	hardened? ( sys-apps/paxctl )
	blas? ( virtual/blas )"

RDEPEND="app-shells/tcsh
	net-misc/openssh
	ifc? ( >=dev-lang/ifc-8.1 )"

S="${WORKDIR}/${PN}"

GAMESS_DOWNLOAD="http://www.msg.ameslab.gov/GAMESS/License_Agreement.html"
GAMESS_VERSION="22 FEB 2006 (R2)"


pkg_nofetch() {
	echo
	einfo "Please download ${PN}-current.tar.gz from"
	einfo "${GAMESS_DOWNLOAD}."
	einfo "Be sure to select the version ${GAMESS_VERSION} tarball!!"
	einfo "Then move the tarball to"
	einfo "${DISTDIR}/${P}.tar.gz"
	echo
}

pkg_setup() {
	# make sure we have the proper fortan compiler; 
	# use ifc for USE="ifc" and g77 otherwise
	if use ifc; then
		need_fortran ifc
	else
		need_fortran gfortran g77
	fi

	# blas and ifc don't go together
	if use blas && use ifc; then
		die  "${PN} can not be compiled with USE=blas and USE=ifc"
	fi
}

src_unpack() {
	unpack ${A}

	# apply LINUX-arch patches to gamess makesfiles
	epatch "${FILESDIR}"/comp-lked-20060222.2.patch
	epatch "${FILESDIR}"/ddi-use-ssh-gentoo.patch
	epatch "${FILESDIR}"/rungms-runall-20060222.2.patch

	# for hardened-gcc let't turn off ssp, since it breakes
	# a few routines
	cd "${S}"
	if use hardened && ([[ ${FORTRANC} = g77 ]]); then
		FFLAGS="${FFLAGS} -fno-stack-protector-all"
	fi

	# some fixes for gfortan; 
	# also append -w otherwise we get flooded with Hollerith 
	# constant warnings
	if [[ ${FORTRANC} == gfortran ]]; then
		FFLAGS="${FFLAGS} -w"

		sed -e "s|-fno-move-all-movables|-w|g" \
			-e "s|*F2C|*F77|g" \
			-e "s|-Wno-globals -fno-globals||g" \
			-i comp || die "Failed removing compile flags"

		# need to use _gfortran_ namespace
		sed -e "s|iargc_|_gfortran_iargc|g" \
			-e "s|getarg_|_gfortran_getarg_i4|g" \
			-i ddi/src/ddi_fortran.c || \
			die "Failed to fix gfortran namespace in ddi_fortran.c"
	fi

	# greate proper activate sourcefile 
	cp "./tools/actvte.code" "./tools/actvte.f" || \
		die || "Failed to create actvte.f"
	sed -e "s/^\*UNX/    /" -i "./tools/actvte.f" || \
		die || "Failed to perform UNX substitutions in actvte.f"

	# fix GAMESS' compall script to use proper CC
	sed -e "s|\$CCOMP -c \$extraflags source/zunix.c|$(tc-getCC) -c \$extraflags source/zunix.c|" \
		-i compall || die "Failed setting up compall script"

	# insert proper FFLAGS into GAMESS' comp makefile
	# in case we're using ifc let's strip all the gcc
	# specific stuff
	if use ifc; then
		sed -e "s/-malign-double -fautomatic /-cm -w \$MODULE.f/" \
			-e "s/-Wno-globals -fno-globals \$MODULE.f//" \
			-e "s/gentoo-OPT = '-O2'/OPT = '${FFLAGS} -quiet'/" \
		    -e "s/gentoo-g77/${FORTANC}/" \
			-i comp || die "Failed setting up comp script"
	else
		sed -e "s/gentoo-OPT = '-O2'/OPT = '${FFLAGS}'/" \
		   	-e "s/gentoo-g77/${FORTRANC}/" \
			-i comp || die "Failed setting up comp script"
	fi

	# use proper blas 
	if ! use blas; then
		sed -e "s|/usr/lib/libblas.a|/usr/lib/dontuselibblas.a|" \
			-i lked || die "Failed to adjust blas in lked"
	fi

	# fix up GAMESS' linker script;
	if use ifc; then
		sed -e "s/gentoo-LDR='g77'/LDR='${FORTRANC}'/" \
		   	-e "s/gentoo-LDOPTS=' '/LDOPTS='${LDFLAGS}'/" \
			-i lked || die "Failed setting up lked script"
	else
		sed -e "s/gentoo-LDR='g77'/LDR='${FORTRANC}'/" \
			-e "s/gentoo-LDOPTS=' '/LDOPTS='${LDFLAGS}'/" \
			-i lked || die "Failed patching lked script"
	fi

	# fix up GAMESS' ddi TCP/IP socket build
	sed -e "s/gentoo-CC = 'gcc'/CC = '$(tc-getCC)'/" \
		-i ddi/compddi || die "Failed setting up compddi script"

	# for ifc/gcc-4.x we have to fix the number of underscores of 
	# fortran symbols, otherwise the linker will barf
	if use ifc || [[ $(gcc-major-version) -ge 4 ]]; then
		sed -e "s/gentoo-F77_OPTS = '-DINT_SIZE=int -D_UNDERSCORES=2/F77_OPTS = '-DINT_SIZE=int -D_UNDERSCORES=1/" \
			-i ddi/compddi || die "Failed fixing underscores in compddi"
	else
		sed -e "s/gentoo-F77_OPTS/F77_OPTS/" \
		    -i ddi/compddi || die "Failed fixing underscores in compddi"
	fi
}

src_compile() {
	# build actvte
	cd "${S}"/tools
	${FORTRANC} -o actvte.x actvte.f || \
		die "Failed to compile actvte.x"

	# for hardened (PAX) users and ifc we need to turn
	# MPROTECT off
	if use ifc && use hardened; then
		/sbin/paxctl -PemRxS actvte.x 2> /dev/null || \
			die "paxctl failed on actvte.x"
	fi

	# build gamess
	cd "${S}"
	./compall || die "compall failed"

	# build the ddi TCP/IP socket stuff
	cd ${S}/"ddi"
	./compddi || die "compddi failed"

	# finally, link it all together
	cd "${S}"
	./lked || die "lked failed"

	# for hardened (PAX) users and ifc we need to turn
	# MPROTECT off
	if use ifc && use hardened; then
		/sbin/paxctl -PemRxS ${PN}.00.x 2> /dev/null || \
			die "paxctl failed on actvte.x"
	fi
}

src_install() {
	cd "${S}"

	# the executables
	dobin ${PN}.00.x ddi/ddikick.x rungms \
		|| die "Failed installing binaries"

	# the docs
	dodoc *.DOC || die "Failed installing docs"

	# install ericftm
	insinto /usr/share/${PN}/ericfmt
	doins ericfmt.dat || die "Failed installing ericfmt.dat"

	# install mcpdata
	insinto /usr/share/${PN}/mcpdata
	doins mcpdata/* || die "Failed installing mcpdata"

	# install the tests the user should run, and
	# fix up the runscript; also grab a copy of rungms
	# so the user is ready to run the tests
	insinto /usr/share/${PN}/tests
	insopts -m0644
	doins tests/* || die "Failed installing tests"
	insopts -m0744
	doins runall || die "Failed installing tests"
}

pkg_postinst() {
	echo
	einfo "Before you use GAMESS for any serious work you HAVE"
	einfo "to run the supplied test files located in"
	einfo "/usr/share/gamess/tests and check them thoroughly."
	einfo "Otherwise all scientific publications resulting from"
	einfo "your GAMESS runs should be immediately rejected :)"
	einfo "To do so copy the content of /usr/share/gamess/tests"
	einfo "to some temporary location and execute './runall'. "
	einfo "Please consult TEST.DOC and the other docs!"

	if [[ ${FORTRANC} == gfortran ]]; then
		echo
		ewarn "If you are using gcc-4.0.x, then due to a gfortran "
		ewarn "implementation issue the TDHF code currently does not"
		ewarn "work and exam39 will, therefore, fail."
		ewarn "If you are using gcc-4.1.x, the resulting binaries "
		ewarn "will likely not run properly. We strongly recommend"
		ewarn "to stick with gcc-3.x or gcc-4.0.x until these issues"
		ewarn "have been addressed."
	fi

	if use ifc; then
		echo
		ewarn "IMPORTANT NOTE: We STRONGLY recommend to stay away"
		ewarn "from ifc-9.0 for now and use the ifc-8.1 series of"
		ewarn "compilers UNLESS you can run through ALL of the "
		ewarn "test cases (see above) successfully."
	fi

	echo
	einfo "If you want to run on more than a single CPU"
	einfo "you will have to acquaint yourself with the way GAMESS"
	einfo "does multiprocessor runs and adjust rungms according to"
	einfo "your target network architecture."
	echo
}
