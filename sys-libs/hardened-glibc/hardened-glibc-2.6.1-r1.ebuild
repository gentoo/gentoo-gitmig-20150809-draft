# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/hardened-glibc/hardened-glibc-2.6.1-r1.ebuild,v 1.3 2008/04/28 00:22:07 pappy Exp $

inherit eutils

# the main installation routine and patches
# from http://www.linuxfromscratch.org/hlfs
# and one file of patches of sys-libs/glibc

DESCRIPTION="Gentoo Hardened GNU libc6"
HOMEPAGE="http://www.gentoo.org/proj/en/hardened/"

KERNELVER="2.6.18"

GNU_MIRROR="ftp://ftp.gnu.org/gnu"

PATCHDIST="http://dev.gentoo.org/~pappy/dist/hardened"
PATCHPATH="sys-libs/hardened-glibc/files/2.6.1"
GENTOOPATCHES="glibc-2.6.1-GENTOOPATCHES.patch.gz"

SRC_URI="${SRC_URI} \
	${GNU_MIRROR}/glibc/glibc-2.6.1.tar.bz2"
SRC_URI="${SRC_URI} \
	${PATCHDIST}/${PATCHPATH}/${GENTOOPATCHES}"

LICENSE="LGPL-2"
SLOT="1"

## !!! dosbin:
## /var/tmp/portage/sys-libs/hardened-glibc-2.6.1-r1/
## work/glibc-2.6.1/gentoo/locale/locale-gen does not exist

KEYWORDS="-x86"
IUSE=""

PROVIDE="virtual/libc"
RESTRICT="strip" #46186

DEPEND=">=sys-devel/binutils-2.15.94
		>=sys-devel/gcc-config-1.3.12
		>=app-misc/pax-utils-0.1.10
		virtual/os-headers
		sys-devel/gettext
		>=sys-apps/portage-2.1.2"

RDEPEND="sys-devel/gettext"

pkg_setup() {
	# hardcoding the CHOST in this ebuild (for x86 stages)
	export CHOST="i486-pc-linux-gnu"

	# CFLAGS+="-march=i686" for undefined reference to
	# `__sync_bool_compare_and_swap_4'
	export CFLAGS="-O2 -pipe -march=i686"
	export CXXFLAGS="${CFLAGS}"

	export CPPFLAGS=""
	export ASFLAGS=""
	export LDFLAGS=""

	if [[ "x${MAKEOPTS}y" == "xy" ]]
	then
		export MAKEOPTS="-j4"
	fi

	einfo "using CHOST:${CHOST}"
	einfo "using C(XX)FLAGS:${CFLAGS}:${CXXFLAGS}"
	einfo "using MAKEOPTS:${MAKEOPTS}"
}

src_compile() {
	cd "${WORKDIR}/glibc-${PV}"

	epatch "${WORKDIR}/glibc-2.6.1-GENTOOPATCHES.patch"

	mkdir -p "${WORKDIR}/glibc-build"
	cd "${WORKDIR}/glibc-build"

	"${WORKDIR}/glibc-${PV}/configure" \
		--target="${CHOST}" \
		--prefix=/usr \
		--enable-bind-now \
		--without-gd \
		--disable-profile \
		--enable-add-ons=nptl \
		--without-selinux \
		--with-tls \
		--with-__thread \
		--enable-kernel="${KERNELVER}" \
		--without-cvs || die "configuration failed"

		make || die "compile failed"
}

src_install() {
	cd "${WORKDIR}/glibc-build"

	make install_root="${D}" install || die "make install failed"

	# NOTE: for installing all glibc locales in the binpackage,
	# NOTE: make install_root="${D}" localedata/install-locales

	insinto /etc

	local configfiles="${WORKDIR}/glibc-${PV}/gentoo"

	# TODO: add locale-gen to the patch

	# install the locale-gen helper utility and config file
	dosbin "${configfiles}/locale/locale-gen" || \
		die "locale-gen helper script could not be installed"

	doins "${configfiles}/locale/locale.gen" || \
		die "locale.gen config file could not be installed"

	# install the nscd startup script
	doinitd "${configfiles}/etc/nscd" || \
		die "nscd run level startup script could not be installed"

	# install the config files for glibc
	doins "${configfiles}"/etc/*.conf || \
		die "glibc config files could not be installed"

	# make sure the localtime is not overwritten by glibc emerges
	rm "${D}/etc/localtime"
}

# NOTE: the locales are not in the .tbz2 file of the binpackage
# NOTE: but will be generated in the postinst routine from here
pkg_postinst() {
	# make sure the file exists on the installed system
	touch "${ROOT}/ld.so.conf"

	# install locales (logic taken from sys-libs/glibc)
	local locale_list="${ROOT}/etc/locale.gen"
	if [[ -z $(locale-gen --list --config "${locale_list}") ]]
	then
		locale_list="${ROOT}/usr/share/i18n/SUPPORTED"
	fi

	# find the number of jobs available
	local x jobs
	for x in ${MAKEOPTS} ; do [[ "${x}" == -j* ]] && jobs=${x#-j} ; done

	# generate the locales
	locale-gen -j ${jobs:-2} --config "${locale_list}"

	# set the timezone automatically if not found
	if [[ ! -f "${ROOT}/etc/localtime" ]]
	then
		einfo "timezone not found: setting timezone to UTC"
		cp --remove-destination \
			"${ROOT}/usr/share/zoneinfo/UTC" \
			"${ROOT}/etc/localtime"
	fi
}

