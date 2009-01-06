# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/boost/boost-1.35.0-r4.ebuild,v 1.1 2009/01/06 15:13:01 dev-zero Exp $

EAPI="2"

inherit python flag-o-matic multilib toolchain-funcs versionator check-reqs

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"

MY_P=${PN}_$(replace_all_version_separators _)
PATCHSET_VERSION="${PV}-5"

DESCRIPTION="Boost Libraries for C++"
HOMEPAGE="http://www.boost.org/"
SRC_URI="mirror://sourceforge/boost/${MY_P}.tar.bz2
	mirror://gentoo/boost-patches-${PATCHSET_VERSION}.tbz2
	http://www.gentoo.org/~dev-zero/distfiles/boost-patches-${PATCHSET_VERSION}.tbz2"
LICENSE="freedist Boost-1.0"
SLOT="0"
IUSE="debug doc expat icu mpi tools"

RDEPEND="icu? ( >=dev-libs/icu-3.3 )
	expat? ( dev-libs/expat )
	mpi? ( || ( sys-cluster/openmpi sys-cluster/mpich2 ) )
	sys-libs/zlib
	virtual/python"
DEPEND="${RDEPEND}
	dev-util/boost-build:${SLOT}"
PDEPEND="app-admin/eselect-boost"

S=${WORKDIR}/${MY_P}

# Maintainer Information
# ToDo:
# - write a patch to support /dev/urandom on FreeBSD and OSX (see below)

# manually setting it for this major version
MAJOR_PV=1_35
BJAM="bjam-${MAJOR_PV}"

pkg_setup() {
	if has test ${FEATURES} ; then
		CHECKREQS_DISK_BUILD="1024"
		check_reqs

		ewarn "The tests may take several hours on a recent machine"
		ewarn "but they will not fail (unless something weird happens ;-)"
		ewarn "This is because the tests depend on the used compiler/-version"
		ewarn "and the platform and upstream says that this is normal."
		ewarn "If you are interested in the results, please take a look at the"
		ewarn "generated results page:"
		ewarn "  ${ROOT}usr/share/doc/${PF}/status/cs-$(uname).html"
		ebeep 5

	fi
}

src_prepare() {
	EPATCH_SOURCE="${WORKDIR}/patches"
	EPATCH_SUFFIX="patch"
	epatch

	epatch "${FILESDIR}/remove_toolset_from_targetname.patch"

	# This enables building the boost.random library with /dev/urandom support
	if ! use userland_Darwin ; then
		mkdir -p libs/random/build
		cp "${FILESDIR}/random-Jamfile" libs/random/build/Jamfile.v2
	fi
}

generate_options() {
	# Maintainer information:
	# The debug-symbols=none and optimization=none
	# are not official upstream flags but a Gentoo
	# specific patch to make sure that all our
	# CXXFLAGS/LDFLAGS are being respected.
	# Using optimization=off would for example add
	# "-O0" and override "-O2" set by the user.
	# Please take a look at the boost-build ebuild
	# for more infomration.

	BUILDNAME="gentoorelease"
	use debug && BUILDNAME="gentoodebug"

	OPTIONS="${BUILDNAME}"

	use icu && OPTIONS="${OPTIONS} -sICU_PATH=/usr"
	if use expat ; then
		OPTIONS="${OPTIONS} -sEXPAT_INCLUDE=/usr/include -sEXPAT_LIBPATH=/usr/$(get_libdir)"
	fi

	if ! use mpi ; then
		OPTIONS="${OPTIONS} --without-mpi"
	fi

	OPTIONS="${OPTIONS} --user-config=${S}/user-config.jam --boost-build=/usr/share/boost-build-${MAJOR_PV}"
}

src_configure() {
	einfo "Writing new user-config.jam"
	python_version

	local compiler compilerVersion compilerExecutable mpi
	if [[ ${CHOST} == *-darwin* ]] ; then
		compiler=darwin
		compilerVersion=$(gcc-version)
		compilerExecutable=$(tc-getCXX)
		append-ldflags -ldl
	else
		compiler=gcc
		compilerVersion=$(gcc-version)
		compilerExecutable=$(tc-getCXX)
	fi

	use mpi && mpi="using mpi ;"

	cat > "${S}/user-config.jam" << __EOF__

variant gentoorelease : release : <optimization>none <debug-symbols>none ;
variant gentoodebug : debug : <optimization>none <debug-symbols>none ;

using ${compiler} : ${compilerVersion} : ${compilerExecutable} : <cxxflags>"${CXXFLAGS}" <linkflags>"${LDFLAGS}" ;
using python : ${PYVER} : /usr : /usr/include/python${PYVER} : /usr/lib/python${PYVER} ;

${mpi}

__EOF__

}

src_compile() {

	NUMJOBS=$(sed -e 's/.*\(\-j[ 0-9]\+\) .*/\1/; s/--jobs=\?/-j/' <<< ${MAKEOPTS})

	generate_options

	elog "Using the following options to build: "
	elog "  ${OPTIONS}"

	export BOOST_ROOT="${S}"

	${BJAM} ${NUMJOBS} -q \
		${OPTIONS} \
		threading=single,multi link=shared,static runtime-link=shared,static \
		--prefix="${D}/usr" \
		--layout=versioned \
		|| die "building boost failed"

	if use tools; then
		cd "${S}/tools/"
		${BJAM} ${NUMJOBS} -q \
			${OPTIONS} \
			--prefix="${D}/usr" \
			--layout=versioned \
			|| die "building tools failed"
	fi

}

src_install () {

	generate_options

	export BOOST_ROOT="${S}"

	${BJAM} -q \
		${OPTIONS} \
		threading=single,multi link=shared,static runtime-link=shared,static \
		--prefix="${D}/usr" \
		--includedir="${D}/usr/include" \
		--libdir="${D}/usr/$(get_libdir)" \
		--layout=versioned \
		install || die "install failed for options '${OPTIONS}'"

	# Move the mpi.so to the right place and make sure it's slotted
	if use mpi; then
		mkdir -p "${D}/usr/$(get_libdir)/python${PYVER}/site-packages/mpi_${MAJOR_PV}"
		mv "${D}/usr/$(get_libdir)/mpi.so" "${D}/usr/$(get_libdir)/python${PYVER}/site-packages/mpi_${MAJOR_PV}/"
		touch "${D}/usr/$(get_libdir)/python${PYVER}/site-packages/mpi_${MAJOR_PV}/__init__.py"
	fi

	if use doc ; then
		find libs -iname "test" -or -iname "src" | xargs rm -rf
		dohtml \
			-A pdf,txt,cpp \
			*.{htm,html,png,css} \
			-r doc more people wiki
		insinto /usr/share/doc/${PF}/html
		doins -r libs

		# To avoid broken links
		insinto /usr/share/doc/${PF}/html
		doins LICENSE_1_0.txt

		dosym /usr/include/boost /usr/share/doc/${PF}/html/boost
	fi

	cd "${D}/usr/$(get_libdir)"

	# Remove (unversioned) symlinks
	# And check for what we remove to catch bugs
	rm libboost_*[!$(get_version_component_range 2)].{a,so}

	# If built with debug enabled, all libraries get a 'd' postfix,
	# this breaks linking other apps against boost (bug #181972)
	if use debug ; then
		for lib in libboost_* ; do
			dosym ${lib} "/usr/$(get_libdir)/$(sed -e 's/-d\././' -e 's/d\././' <<< ${lib})"
		done
	fi

	for lib in libboost_thread-mt-{s-${MAJOR_PV}.a,${MAJOR_PV}.a,${MAJOR_PV}.so} ; do
		dosym ${lib} "/usr/$(get_libdir)/$(sed -e 's/-mt//' <<< ${lib})"
	done

	if use tools; then
		cd "${S}/dist/bin"
		# Append version postfix to binaries for slotting
		for b in * ; do
			newbin "${b}" "${b}-${MAJOR_PV}"
		done

		cd "${S}/dist"
		insinto /usr/share
		doins -r share/boostbook
		# Append version postfix for slotting
		mv "${D}/usr/share/boostbook" "${D}/usr/share/boostbook-${MAJOR_PV}"
	fi

	cd "${S}/status"
	if [ -f regress.log ] ; then
		docinto status
		dohtml *.{html,gif} ../boost.png
		dodoc regress.log
	fi

	python_need_rebuild
}

src_test() {
	generate_options

	export BOOST_ROOT=${S}

	cd "${S}/tools/regression/build"
	${BJAM} -q \
		${OPTIONS} \
		--prefix="${D}/usr" \
		--layout=versioned \
		process_jam_log compiler_status \
		|| die "building regression test helpers failed"

	cd "${S}/status"

	# Some of the test-checks seem to rely on regexps
	export LC_ALL="C"

	# The following is largely taken from tools/regression/run_tests.sh,
	# but adapted to our needs.

	# Run the tests & write them into a file for postprocessing
	${BJAM} \
		${OPTIONS} \
		--dump-tests 2>&1 | tee regress.log

	# Postprocessing
	cat regress.log | "${S}/tools/regression/build/bin/gcc-$(gcc-version)/${BUILDNAME}/process_jam_log" --v2
	if test $? != 0 ; then
		die "Postprocessing the build log failed"
	fi

	cat > "${S}/status/comment.html" <<- __EOF__
		<p>Tests are run on a <a href="http://www.gentoo.org">Gentoo</a> system.</p>
__EOF__

	# Generate the build log html summary page
	"${S}/tools/regression/build/bin/gcc-$(gcc-version)/${BUILDNAME}/compiler_status" --v2 \
		--comment "${S}/status/comment.html" "${S}" \
		cs-$(uname).html cs-$(uname)-links.html
	if test $? != 0 ; then
		die "Generating the build log html summary page failed"
	fi

	# And do some cosmetic fixes :)
	sed -i -e 's|../boost.png|boost.png|' *.html
}
