# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/v8/v8-9999.ebuild,v 1.17 2011/10/22 11:44:36 phajdan.jr Exp $

EAPI="3"

PYTHON_DEPEND="2:2.6"

inherit eutils multilib pax-utils python subversion toolchain-funcs

DESCRIPTION="Google's open source JavaScript engine"
HOMEPAGE="http://code.google.com/p/v8"
ESVN_REPO_URI="http://v8.googlecode.com/svn/trunk"
LICENSE="BSD"

SLOT="0"
KEYWORDS=""
IUSE=""

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	subversion_src_unpack
	cd "${S}"
	make dependencies || die
}

src_compile() {
	tc-export AR CC CXX RANLIB
	export LINK="${CXX}"

	# Use target arch detection logic from bug #354601.
	case ${CHOST} in
		i?86-*) myarch=ia32 ;;
		x86_64-*)
			if [[ $ABI = x86 ]] ; then
				myarch=ia32
			else
				myarch=x64
			fi ;;
		arm*-*) myarch=arm ;;
		*) die "Unrecognized CHOST: ${CHOST}"
	esac
	mytarget=${myarch}.release

	if [[ ${PV} == "9999" ]]; then
		subversion_wc_info
		soname_version="${PV}-${ESVN_WC_REVISION}"
	else
		soname_version="${PV}"
	fi

	local snapshot=on
	host-is-pax && snapshot=off

	# TODO: Add console=readline option once implemented upstream
	# http://code.google.com/p/v8/issues/detail?id=1781

	emake V=1 \
		library=shared \
		werror=no \
		soname_version=${soname_version} \
		snapshot=${snapshot} \
		${mytarget} || die

	pax-mark m out/${mytarget}/{cctest,d8,shell} || die
}

src_test() {
	tools/test-wrapper-gypbuild.py \
		--arch-and-mode=${mytarget} \
		--no-presubmit \
		--progress=dots || die
}

src_install() {
	insinto /usr
	doins -r include || die

	dobin out/${mytarget}/d8 || die

	if [[ ${CHOST} == *-darwin* ]] ; then
		install_name_tool \
			-id "${EPREFIX}"/usr/$(get_libdir)/libv8-${soname_version}$(get_libname) \
			out/${mytarget}/lib.target/libv8-${soname_version}$(get_libname) || die
	fi

	dolib out/${mytarget}/lib.target/libv8-${soname_version}$(get_libname) || die
	dosym libv8-${soname_version}$(get_libname) /usr/$(get_libdir)/libv8$(get_libname) || die

	dodoc AUTHORS ChangeLog || die
}

pkg_preinst() {
	local preserved_candidates="$(find /usr/$(get_libdir) -maxdepth 1 -name libv8-\*$(get_libname))"
	preserved_libs=""
	for candidate in ${preserved_candidates}; do
		if [[ -f "${D}/usr/$(get_libdir)/`basename ${candidate}`" ]]; then
			continue
		fi
		preserved_libs+=" ${candidate}"
	done
	if [[ "${preserved_libs}" != "" ]]; then
		preserve_old_lib ${preserved_libs}
	fi
}

pkg_postinst() {
	if [[ "${preserved_libs}" != "" ]]; then
		preserve_old_lib_notify ${preserved_libs}
	fi
}
