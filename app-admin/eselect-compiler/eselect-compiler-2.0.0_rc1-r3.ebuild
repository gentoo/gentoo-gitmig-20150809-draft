# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/eselect-compiler/eselect-compiler-2.0.0_rc1-r3.ebuild,v 1.1 2006/06/01 09:24:12 eradicator Exp $

inherit eutils multilib toolchain-funcs

DESCRIPTION="Utility to configure the active toolchain compiler"
HOMEPAGE="http://www.gentoo.org/"

MY_PN="compiler-config"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

SRC_URI=" http://dev.gentoo.org/~eradicator/toolchain/${MY_PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE="hardened"

RDEPEND=">=app-admin/eselect-1.0_rc1"

# We want to verify that compiler profiles exist for our toolchain
pkg_setup() {
	local abi
	for abi in $(get_all_abis) ; do
		local ctarget=$(get_abi_CHOST ${abi})
		if ! grep -q "^[[:space:]]*ctarget=${ctarget}$" ${ROOT}/etc/eselect/compiler/*.conf ; then
			eerror "We weren't able to find a valid eselect compiler profile for ${abi}."
			eerror "Please do the following to re-emerge gcc, then retry emerging"
			eerror "eselect-compiler:"
			eerror "# emerge -v --oneshot sys-devel/gcc"

			die "Missing eselect-compiler profile for ${abi}"
		fi
	done
}

pkg_postinst() {
	# Some toolchain.eclass installed confs had some bugs that need fixing
	sed -i 's:chost:ctarget:g' ${ROOT}/etc/eselect/compiler/*
	sed -i 's:spec=:specs=:g' ${ROOT}/etc/eselect/compiler/*

	# Activate the profiles
	if [[ ! -f "${ROOT}/etc/eselect/compiler/selection.conf" ]] ; then
		ewarn "This looks like the first time you are installing eselect-compiler.  We are"
		ewarn "activating toolchain profiles for the CTARGETs needed by your portage"
		ewarn "profile You should have profiles installed from compilers that you emerged"
		ewarn "after October, 2005. If a compiler you have installed is missing an"
		ewarn "eselect-compiler profile, you can either re-emerge the compiler, create the"
		ewarn "profile yourself, or you can migrate profiles from gcc-config-1.x by doing:"
		ewarn "# eselect compiler migrate"
		ewarn
		ewarn "Note that if you use the migration tool, your current profiles will be"
		ewarn "replaced, so you should backup the data in /etc/eselect/compiler first."
		echo
		einfo "The following profiles have been activated.  If an incorrect profile is"
		einfo "chosen or an error is reported, please use 'eselect compiler set' to"
		einfo "manually choose it"

		local abi
		for abi in $(get_all_abis) ; do
			local ctarget=$(get_abi_CHOST ${abi})
			local extra_options=""

			if [[ ${abi} == ${DEFAULT_ABI} ]] ; then
				extra_options="-n"
			fi

			local spec
			if use hardened ; then
				spec="hardened"
			else
				spec="vanilla"
			fi

			local isset=0
			local tuple
			for tuple in "${CHOST}" "${CTARGET}" "${ctarget}" ; do
				local version
				for version in "$(gcc-fullversion)" ; do
					local profile
					for profile in "${abi}-${spec}" "${spec}" "${abi}-default" "default" "${abi}-vanilla" "vanilla" ; do
						if eselect compiler set ${tuple}-${version}/${profile} ${extra_options} &> /dev/null ; then
							einfo "${abi}: ${tuple}-${version}/${profile}"

							isset=1
							break
						fi
					done
					[[ ${isset} == 1 ]] && break
				done
				[[ ${isset} == 1 ]] && break
			done

			if [[ ${isset} == 0 ]] ; then
				eerror "${abi}: Unable to determine an appropriate profile.  Please set manually."
			fi
		done
	else
		eselect compiler update
	fi

	if rm -f ${ROOT}/etc/env.d/05gcc* &> /dev/null ; then
		echo
		ewarn "You should source /etc/profile in your open shells."
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-inherit.patch
}

src_install() {
	dodoc README
	make DESTDIR="${D}" install || die

	doenvd ${FILESDIR}/25eselect-compiler

	# This is installed by sys-devel/gcc-config
	rm ${D}/usr/bin/gcc-config
}
