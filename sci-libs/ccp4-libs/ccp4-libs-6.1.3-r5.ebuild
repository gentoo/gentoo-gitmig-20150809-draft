# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ccp4-libs/ccp4-libs-6.1.3-r5.ebuild,v 1.1 2010/12/31 12:24:48 jlec Exp $

EAPI="3"

inherit eutils gnuconfig multilib toolchain-funcs

SRC="ftp://ftp.ccp4.ac.uk/ccp4"

#UPDATE="04_03_09"
#PATCHDATE="090511"

MY_P="${P/-libs}"

PATCH_TOT="0"
# Here's a little scriptlet to generate this list from the provided
# index.patches file
#
# i=1; while read -a line; do [[ ${line//#} != ${line} ]] && continue;
# echo "PATCH${i}=( ${line[1]}"; echo "${line[0]} )"; (( i++ )); done <
# index.patches
#PATCH1=( src/topp_
#topp.f-r1.16.2.5-r1.16.2.6.diff )
#PATCH2=( .
#configure-r1.372.2.18-r1.372.2.19.diff )

DESCRIPTION="Protein X-ray crystallography toolkit"
HOMEPAGE="http://www.ccp4.ac.uk/"
SRC_URI="${SRC}/${PV}/${MY_P}-core-src.tar.gz"
# patch tarball from upstream
	[[ -n ${UPDATE} ]] && SRC_URI="${SRC_URI} ${SRC}/${PV}/updates/${P}-src-patch-${UPDATE}.tar.gz"
# patches created by us
	[[ -n ${PATCHDATE} ]] && SRC_URI="${SRC_URI} http://dev.gentooexperimental.org/~jlec/science-dist/${PV}-${PATCHDATE}-updates.patch.bz2"

for i in $(seq $PATCH_TOT); do
	NAME="PATCH${i}[1]"
	SRC_URI="${SRC_URI}
		${SRC}/${PV}/patches/${!NAME}"
done

LICENSE="ccp4"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	virtual/jpeg
	app-shells/tcsh
	!<sci-chemistry/ccp4-6.1.3
	!<sci-chemistry/ccp4-apps-6.1.3-r6
	sci-libs/cbflib
	=sci-libs/fftw-2*
	sci-libs/mmdb
	sci-libs/monomer-db
	virtual/lapack
	virtual/blas"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	einfo "Applying upstream patches ..."
	for patch in $(seq $PATCH_TOT); do
		base="PATCH${patch}"
		dir=$(eval echo \${${base}[0]})
		p=$(eval echo \${${base}[1]})
		pushd "${dir}" >& /dev/null
		ccp_patch "${DISTDIR}/${p}"
		popd >& /dev/null
	done
	einfo "Done."
	echo

	[[ -n ${PATCHDATE} ]] && epatch "${WORKDIR}"/${PV}-${PATCHDATE}-updates.patch

	einfo "Applying Gentoo patches ..."
	# fix buffer overflows wrt bug 339706
	ccp_patch "${FILESDIR}"/${PV}-overflows.patch

	# it tries to create libdir, bindir etc on live system in configure
	ccp_patch "${FILESDIR}"/${PV}-dont-make-dirs-in-configure.patch

	# gerror_ gets defined twice on ppc if you're using gfortran/g95
	ccp_patch "${FILESDIR}"/6.0.2-ppc-double-define-gerror.patch

	# make creation of libccif.so smooth
	ccp_patch "${FILESDIR}"/${PV}-ccif-shared.patch

	# lets try to build libmmdb seperatly
	ccp_patch "${FILESDIR}"/${PV}-dont-build-mmdb.patch

	# unbundle libjpeg and cbflib
	ccp_patch "${FILESDIR}"/${PV}-unbundle-libs.patch

	# Fix missing DESTIDR
	# not installing during build
	ccp_patch "${FILESDIR}"/${PV}-noinstall.patch
	sed \
		-e '/SHARE_INST/s:$(libdir):$(DESTDIR)/$(libdir):g' \
		-i configure || die

	einfo "Done." # done applying Gentoo patches
	echo

	sed \
		-e "s:/usr:${EPREFIX}/usr:g" \
		-e 's:-Wl,-rpath,$CLIB::g' \
		-e 's: -rpath $CLIB::g' \
		-e 's: -I${srcdir}/include/cpp_c_headers::g' \
		-i configure || die

	gnuconfig_update
}

src_configure() {

	rm -rf lib/DiffractionImage/{jpg,CBFlib} || die

	# Build system is broken if we set LDFLAGS
	userldflags="${LDFLAGS}"
	export SHARED_LIB_FLAGS="${LDFLAGS}"
	unset LDFLAGS

	# GENTOO_OSNAME can be one of:
	# irix irix64 sunos sunos64 aix hpux osf1 linux freebsd
	# linux_compaq_compilers linux_intel_compilers generic Darwin
	# ia64_linux_intel Darwin_ibm_compilers linux_ibm_compilers
	if [[ "$(tc-getFC)" = "ifort" ]]; then
		if use ia64; then
			GENTOO_OSNAME="ia64_linux_intel"
		else
			# Should be valid for x86, maybe amd64
			GENTOO_OSNAME="linux_intel_compilers"
		fi
	else
		# Should be valid for x86 and amd64, at least
		GENTOO_OSNAME="linux"
	fi

	# Sets up env
	ln -s \
		ccp4.setup-bash \
		"${S}"/include/ccp4.setup

	# We agree to the license by emerging this, set in LICENSE
	sed -i \
		-e "s~^\(^agreed=\).*~\1yes~g" \
		"${S}"/configure

	# Fix up variables -- need to reset CCP4_MASTER at install-time
	sed -i \
		-e "s~^\(setenv CCP4_MASTER.*\)/.*~\1"${WORKDIR}"~g" \
		-e "s~^\(setenv CCP4I_TCLTK.*\)/usr/local/bin~\1${EPREFIX}/usr/bin~g" \
		"${S}"/include/ccp4.setup*

	# Set up variables for build
	source "${S}"/include/ccp4.setup

	export CC=$(tc-getCC)
	export CXX=$(tc-getCXX)
	export COPTIM=${CFLAGS}
	export CXXOPTIM=${CXXFLAGS}
	# Default to -O2 if FFLAGS is unset
	export FC=$(tc-getFC)
	export FOPTIM=${FFLAGS:- -O2}
#	export CCP4_SCR="${T}"

	# Fix linking
#	$(tc-getCC) ${userldflags} -shared -Wl,-soname,libmmdb.so -o libmmdb.so \${MMDBOBJS} $(gcc-config -L | awk -F: '{for(i=1; i<=NF; i++) printf " -L%s", $i}') -lm -lstdc++ && \
	export SHARE_LIB="\
		$(tc-getCC) ${userldflags} -shared -Wl,-soname,libccp4c.so -o libccp4c.so \${CORELIBOBJS} \${CGENERALOBJS} \${CUCOBJS} \${CMTZOBJS} \${CMAPOBJS} \${CSYMOBJS} -L../ccif/ -lccif $(gcc-config -L | awk -F: '{for(i=1; i<=NF; i++) printf " -L%s", $i}') -lm && \
		$(tc-getFC) ${userldflags} -shared -Wl,-soname,libccp4f.so -o libccp4f.so \${FORTRANLOBJS} \${FINTERFACEOBJS} -L../ccif/ -lccif -L. -lccp4c -lmmdb $(gcc-config -L | awk -F: '{for(i=1; i<=NF; i++) printf " -L%s", $i}') -lstdc++ -lgfortran -lm"

	# Can't use econf, configure rejects unknown options like --prefix
	./configure \
		--onlylibs \
		--with-shared-libs \
		--with-fftw="${EPREFIX}"/usr \
		--with-warnings \
		--disable-cctbx \
		--disable-clipper \
		--tmpdir="${TMPDIR}" \
		--bindir="${EPREFIX}"/usr/libexec/ccp4/bin/ \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		${GENTOO_OSNAME} || die "econf failed"
}

src_compile() {
	emake -j1 \
		DESTDIR="${D}" onlylib || die "emake failed"
}

src_install() {
	# Set up variables for build
	source "${S}"/include/ccp4.setup

	emake -j1 \
		DESTDIR="${D}" \
		includedir="${EPREFIX}"/usr/include \
		library_includedir="${EPREFIX}"/usr/include \
		install || die

	# Libs
	for file in "${S}"/lib/*; do
		if [[ -d ${file} ]]; then
			continue
		elif [[ -x ${file} ]]; then
			dolib.so ${file} || die
		else
			insinto /usr/$(get_libdir)
			doins ${file} || die
		fi
	done

	# Fix libdir in all *.la files
	sed -i \
		-e "s:^\(libdir=\).*:\1\'${EPREFIX}/usr/$(get_libdir)\':g" \
		"${ED}"/usr/$(get_libdir)/*.la || die

	# Data
	insinto /usr/share/ccp4/data/
	doins -r "${S}"/lib/data/{*.PARM,*.prt,*.lib,*.dic,*.idl,*.cif,*.resource,*.york,*.hist,fraglib,reference_structures} || die

	# Environment files, setup scripts, etc.
	rm -rf "${S}"/include/{ccp4.setup*,COPYING,cpp_c_headers} || die
	insinto /usr/share/ccp4/
	doins -r "${S}"/include || die

	dodoc "${S}"/lib/data/*.doc || die
	newdoc "${S}"/lib/data/README DATA-README || die
}

# Epatch wrapper for bulk patching
ccp_patch() {
	EPATCH_SINGLE_MSG="  ${1##*/} ..." epatch ${1}
}
