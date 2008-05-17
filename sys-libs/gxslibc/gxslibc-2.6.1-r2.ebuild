# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/gxslibc/gxslibc-2.6.1-r2.ebuild,v 1.1 2008/05/17 11:48:55 pappy Exp $

# the main installation routine and patches
# from http://www.linuxfromscratch.org/hlfs

DESCRIPTION="The Gentoo Linux Extreme Security version of the GNU libc6"

HOMEPAGE="http://www.gentoo.org/proj/en/extreme-security/"

# currently the only CHOST supported for this ebuild
WANT_CHOST="i486-pc-linux-gnu"

RELEASE="2.6.1"

KERNELVER="2.6.18"

GNU_MIRROR="ftp://ftp.gnu.org/gnu"

PATCHDIST="http://dev.gentoo.org/~pappy/dist/gxs"
PATCHPATH="sys-libs/gxslibc/files/${RELEASE}"
MYPATCHES="glibc-${RELEASE}-gxs-GENTOOPATCHES.patch.gz"
LOCALEGEN="glibc-${RELEASE}-gxs-LOCALEGEN_NSCD.patch.gz"
GXSSPATCH="glibc-${RELEASE}-gxs-ssp.patch.gz"

## the default upstream glibc
SRC_URI="${SRC_URI} ${GNU_MIRROR}/glibc/glibc-${RELEASE}.tar.bz2"

# comment out - already provided by gentoo patches
# ${GNU_MIRROR}/glibc/glibc-libidn-${RELEASE}.tar.bz2"

## contains a jumbo file with all patches from
## sys-libs/glibc for this particular glibc setup
SRC_URI="${SRC_URI} ${PATCHDIST}/${PATCHPATH}/${MYPATCHES}"

## uses locale-gen from sys-libs/glibc
## which in turn was taken from Debian
SRC_URI="${SRC_URI} ${PATCHDIST}/${PATCHPATH}/${LOCALEGEN}"

## GXS backport of SSP for >=glibc-2.4
SRC_URI="${SRC_URI} ${PATCHDIST}/${PATCHPATH}/${GXSSPATCH}"

LICENSE="LGPL-2"

SLOT="1"

# this ebuild only works on ARCH=x86 so far
# (see CHOST notice above)
KEYWORDS="~x86"

# nls: not supported (test for -nls)
# nptl,nptlonly: no linuxthreads
IUSE="nls nptl nptlonly"

# remove the remaining non-colliding
# files from the orig sys-libs/glibc
# package with the following command
# when finished emerging this glibc:
#
# CONFIG_PROTECT="$(echo -n $(equery files sys-libs/gxslibc))" \
# emerge -C sys-libs/glibc
#
# you also need to emerge gentoolkit
# to run the equery inside the shell
# command for setting up the env var
PROVIDE="virtual/libc"

RESTRICT="strip" #46186

# we share a header file with gettext which seems
# to make net-tools and busybox fail with linking
# errors regarding to a libintl_gettext not found
DEPEND=">=sys-devel/binutils-2.15.94
		>=sys-devel/gcc-config-1.3.12
		>=app-misc/pax-utils-0.1.10
		virtual/os-headers
		>=sys-apps/portage-2.1.2
		!sys-devel/gettext"

pkg_setup() {

	einfo "checking use flags:-nls, nptl, nptlonly"
	if (!( (!(use nls)) && (use nptl) && (use nptlonly) ))
	then
		eerror "please set USE=-nls to use this ebuild"
		eerror "and enable nptl and nptlonly USE flags"
		echo
		exit 1
	fi

	einfo "checking CHOST: ${CHOST}"

	if [[ "x${CHOST}y" != "x${WANT_CHOST}y" ]]
	then
		ewarn "for using this ebuild you need to have"
		ewarn "your stage CHOST set to ${WANT_CHOST}"
		eerror "bailing out: CHOST not compatible with ebuild"
		exit 1
	else
		export CHOST="i486-pc-linux-gnu"
	fi

	einfo "overriding CFLAGS and CXXFLAGS for ebuild"
	export CFLAGS="-O2 -pipe -march=i486 -mtune=i686 -fforce-addr -g -ggdb"
	export CXXFLAGS="${CFLAGS}"

	einfo "clearing CPPFLAGS ASFLAGS LDFLAGS for ebuild"
	export CPPFLAGS=""
	export ASFLAGS=""
	export LDFLAGS=""

	if [[ "x${MAKEOPTS}y" == "xy" ]]
	then
		einfo "setting MAKEOPTS for ebuild"
		export MAKEOPTS="-j4"
	fi

	einfo "using CHOST:${CHOST}"
	einfo "using C(XX)FLAGS:${CXXFLAGS}"
	einfo "using MAKEOPTS:${MAKEOPTS}"
}

src_compile() {

	cd "${WORKDIR}/glibc-${RELEASE}"

	einfo "adding gentoo glibc patches"
	patch -p1 --quiet < \
		"${WORKDIR}/glibc-${RELEASE}-gxs-GENTOOPATCHES.patch" || \
		die "could not apply gentoo patches"

	einfo "adding localegen utility and nscd files"
	patch -p1 --quiet < \
		"${WORKDIR}/glibc-${RELEASE}-gxs-LOCALEGEN_NSCD.patch" || \
		die "could not apply localegen patch"

	einfo "adding GXS SSP patch"
	patch -p1 --quiet < \
		"${WORKDIR}/glibc-${RELEASE}-gxs-ssp.patch" || \
		die "could not add GXS SSP patch"

	mkdir -p "${WORKDIR}/glibc-build"
	cd "${WORKDIR}/glibc-build"

	"${WORKDIR}/glibc-${PV}/configure" \
		--target="${CHOST}" \
		--prefix=/usr \
		--enable-bind-now \
		--without-gd \
		--disable-profile \
		--disable-libssp \
		--disable-nls \
		--enable-add-ons=nptl,libidn \
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

	insinto /etc

	local configfiles="${WORKDIR}/glibc-${PV}/gentoo"

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
	touch "${ROOT}/etc/ld.so.conf"

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

	einfo "tuning directory and file permissions"
	chown -v root:root "${ROOT}/etc/locale.gen"
	chmod -v 0644 "${ROOT}/etc/locale.gen"

	for TDIR in "${ROOT}/" \
				"${ROOT}/etc"
	do
		chown -v root:root "${TDIR}"
		chmod -v 0755 "${TDIR}"
	done

	for FILE in "${ROOT}/etc/locale.gen" \
				"${ROOT}/etc/nscd.conf"
	do
		chown -v root:root "${FILE}"
		chmod -v 0644 "${FILE}"
	done
}
#eof#
