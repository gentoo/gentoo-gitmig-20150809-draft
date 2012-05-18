# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-freebsd/freebsd-lib/freebsd-lib-9.0-r2.ebuild,v 1.20 2012/05/18 16:37:26 aballier Exp $

EAPI=2

inherit bsdmk freebsd flag-o-matic multilib toolchain-funcs

DESCRIPTION="FreeBSD's base system libraries"
SLOT="0"
KEYWORDS="~amd64-fbsd ~sparc-fbsd ~x86-fbsd"

# Crypto is needed to have an internal OpenSSL header
# sys is needed for libalias, probably we can just extract that instead of
# extracting the whole tarball
SRC_URI="mirror://gentoo/${LIB}.tar.bz2
		mirror://gentoo/${CONTRIB}.tar.bz2
		mirror://gentoo/${CRYPTO}.tar.bz2
		mirror://gentoo/${LIBEXEC}.tar.bz2
		mirror://gentoo/${ETC}.tar.bz2
		mirror://gentoo/${INCLUDE}.tar.bz2
		mirror://gentoo/${USBIN}.tar.bz2
		mirror://gentoo/${GNU}.tar.bz2
		build? (
			mirror://gentoo/${SYS}.tar.bz2 )
		zfs? (
			mirror://gentoo/${CDDL}.tar.bz2 )"

if [ "${CATEGORY#*cross-}" = "${CATEGORY}" ]; then
	RDEPEND="ssl? ( dev-libs/openssl )
		hesiod? ( net-dns/hesiod )
		kerberos? ( virtual/krb5 )
		usb? ( !dev-libs/libusb )
		zfs? ( =sys-freebsd/freebsd-cddl-${RV}* )
		>=dev-libs/expat-2.0.1
		!sys-libs/libutempter
		!sys-freebsd/freebsd-headers"
	DEPEND="${RDEPEND}
		>=sys-devel/flex-2.5.31-r2
		=sys-freebsd/freebsd-sources-${RV}*
		!bootstrap? ( app-arch/bzip2 )"
else
	SRC_URI="${SRC_URI}
			mirror://gentoo/${SYS}.tar.bz2"
fi

DEPEND="${DEPEND}
		=sys-freebsd/freebsd-mk-defs-${RV}*"

S="${WORKDIR}/lib"

export CTARGET=${CTARGET:-${CHOST}}
if [ "${CTARGET}" = "${CHOST}" -a "${CATEGORY#*cross-}" != "${CATEGORY}" ]; then
	export CTARGET=${CATEGORY/cross-}
fi

IUSE="atm bluetooth ssl hesiod ipv6 kerberos usb netware
	build bootstrap crosscompile_opts_headers-only zfs
	userland_GNU userland_BSD"

pkg_setup() {
	[ -c /dev/zero ] || \
		die "You forgot to mount /dev; the compiled libc would break."

	if ! use ssl && use kerberos; then
		eerror "If you want kerberos support you need to enable ssl support, too."
	fi

	use atm || mymakeopts="${mymakeopts} WITHOUT_ATM= "
	use bluetooth || mymakeopts="${mymakeopts} WITHOUT_BLUETOOTH= "
	use hesiod || mymakeopts="${mymakeopts} WITHOUT_HESIOD= "
	use ipv6 || mymakeopts="${mymakeopts} WITHOUT_INET6_SUPPORT= "
	use kerberos || mymakeopts="${mymakeopts} WITHOUT_KERBEROS_SUPPORT= "
	use netware || mymakeopts="${mymakeopts} WITHOUT_IPX= WITHOUT_IPX_SUPPORT= WITHOUT_NCP= "
	use ssl || mymakeopts="${mymakeopts} WITHOUT_OPENSSL= "
	use usb || mymakeopts="${mymakeopts} WITHOUT_USB= "
	use zfs || mymakeopts="${mymakeopts} WITHOUT_CDDL= "

	mymakeopts="${mymakeopts} WITHOUT_BIND= WITHOUT_BIND_LIBS= WITHOUT_SENDMAIL= WITHOUT_CLANG= "

	if [ "${CTARGET}" != "${CHOST}" ]; then
		mymakeopts="${mymakeopts} MACHINE=$(tc-arch-kernel ${CTARGET})"
		mymakeopts="${mymakeopts} MACHINE_ARCH=$(tc-arch-kernel ${CTARGET})"
	fi
}

PATCHES=(
	"${FILESDIR}/${PN}-6.0-gccfloat.patch"
	"${FILESDIR}/${PN}-6.0-flex-2.5.31.patch"
	"${FILESDIR}/${PN}-6.1-csu.patch"
	"${FILESDIR}/${PN}-8.0-rpcsec_gss.patch"
	"${FILESDIR}/${PN}-9.0-liblink.patch"
	"${FILESDIR}/${PN}-bsdxml2expat.patch" )

# Here we disable and remove source which we don't need or want
# In order:
# - ncurses stuff
# - libexpat creates a bsdxml library which is the same as expat
# - archiving libraries (have their own ebuild)
# - sendmail libraries (they are installed by sendmail)
# - SNMP library and dependency (have their own ebuilds)
#
# The rest are libraries we already have somewhere else because
# they are contribution.
# Note: libtelnet is an internal lib used by telnet and telnetd programs
# as it's not used in freebsd-lib package itself, it's pointless building
# it here.
REMOVE_SUBDIRS="ncurses \
	libexpat \
	libz libbz2 libarchive liblzma \
	libsm libsmdb libsmutil \
	libbegemot libbsnmp \
	libpam libpcap bind libwrap libmagic \
	libcom_err libtelnet
	libelf libedit"

src_prepare() {
	sed -i.bak -e 's:-o/dev/stdout:-t:' "${S}/libc/net/Makefile.inc"
	sed -i.bak -e 's:histedit.h::' "${WORKDIR}/include/Makefile"

	# Upstream Display Managers default to using VT7
	# We should make FreeBSD allow this by default
	local x=
	for x in "${WORKDIR}"/etc/etc.*/ttys ; do
		sed -i.bak \
			-e '/ttyv5[[:space:]]/ a\
# Display Managers default to VT7.\
# If you use the xdm init script, keep ttyv6 commented out\
# unless you force a different VT for the DM being used.' \
			-e '/^ttyv[678][[:space:]]/ s/^/# /' "${x}" \
			|| die "Failed to sed ${x}"
		rm "${x}".bak
	done

	# This one is here because it also
	# patches "${WORKDIR}/include"
	cd "${WORKDIR}"
	epatch "${FILESDIR}/${PN}-includes.patch"
	epatch "${FILESDIR}/${PN}-8.0-gcc45.patch"

	# Don't install the hesiod man page or header
	rm "${WORKDIR}"/include/hesiod.h || die
	sed -i.bak -e 's:hesiod.h::' "${WORKDIR}"/include/Makefile || die
	sed -i.bak -e 's:hesiod.c::' -e 's:hesiod.3::' \
	"${WORKDIR}"/lib/libc/net/Makefile.inc || die

	# Fix the Makefiles of these few libraries that will overwrite our LDADD.
	cd "${S}"
	for dir in libradius libtacplus libcam libdevstat libfetch libgeom libmemstat libopie \
		libsmb; do sed -i.bak -e 's:LDADD=:LDADD+=:g' "${dir}/Makefile" || \
		die "Problem fixing \"${dir}/Makefile"
	done
	if use build; then
		cd "${WORKDIR}"
		# This patch has to be applied on ${WORKDIR}/sys, so we do it here since it
		# shouldn't be a symlink to /usr/src/sys (which should be already patched)
		epatch "${FILESDIR}"/${PN}-7.1-types.h-fix.patch
		# Preinstall includes so we don't use the system's ones.
		mkdir "${WORKDIR}/include_proper" || die "Couldn't create ${WORKDIR}/include_proper"
		install_includes "/include_proper"
		return 0
	fi

	if [ "${CTARGET}" = "${CHOST}" ]; then
		ln -s "/usr/src/sys-${RV}" "${WORKDIR}/sys" || die "Couldn't make sys symlink!"
	else
		sed -i.bak -e "s:/usr/include:/usr/${CTARGET}/usr/include:g" \
			"${S}/libc/rpc/Makefile.inc" \
			"${S}/libc/yp/Makefile.inc"
	fi

	if install --version 2> /dev/null | grep -q GNU; then
		sed -i.bak -e 's:${INSTALL} -C:${INSTALL}:' "${WORKDIR}/include/Makefile"
	fi

	# Let arch-specific includes to be found
	local machine
	machine=$(tc-arch-kernel ${CTARGET})
	ln -s "${WORKDIR}/sys/${machine}/include" "${WORKDIR}/include/machine" || \
		die "Couldn't make ${machine}/include symlink."

	cd "${S}"
	use bootstrap && dummy_mk libstand
	# Call LD with LDFLAGS, rename them to RAW_LDFLAGS
	sed -e 's/LDFLAGS/RAW_LDFLAGS/g' \
		-i "${S}/csu/i386-elf/Makefile" \
		-i "${S}/csu/ia64/Makefile" || die
	# Try to fix sed calls for GNU sed. Do it only with GNU userland and force
	# BSD's sed on BSD.
	if use userland_GNU; then
		find . -name Makefile -exec sed -ibak 's/sed -i /sed -i/' {} \;
	fi
}

get_csudir() {
	if [ -d "${WORKDIR}/lib/csu/$1-elf" ]; then
		echo "lib/csu/$1-elf"
	else
		echo "lib/csu/$1"
	fi
}

bootstrap_csu() {
	local csudir="$(get_csudir $(tc-arch-kernel ${CTARGET}))"
	export RAW_LDFLAGS=$(raw-ldflags)
	cd "${WORKDIR}/${csudir}" || die "Missing ${csudir}."
	freebsd_src_compile

	append-flags "-B ${WORKDIR}/${csudir}"
	append-ldflags "-B ${WORKDIR}/${csudir}"
}

# Compile libssp_nonshared.a and add it's path to LDFLAGS.
bootstrap_libssp_nonshared() {
	cd "${WORKDIR}/gnu/lib/libssp/libssp_nonshared/" || die "missing libssp."
	freebsd_src_compile
	append-ldflags "-L${WORKDIR}/gnu/lib/libssp/libssp_nonshared/"
	export LDADD="-lssp_nonshared"
}

# What to build for a non-native build: cross-compiler, non-native abi in
# multilib. We also need the csu but this has to be handled separately.
NON_NATIVE_SUBDIRS="lib/libc lib/msun gnu/lib/libssp lib/libthr lib/libutil"

# Subdirs for a native build:
NATIVE_SUBDIRS="lib gnu/lib/libssp gnu/lib/libregex"

src_compile() {
	# Does not work with GNU sed
	# Force BSD's sed on BSD.
	if use userland_BSD ; then
		export ESED=/usr/bin/sed
		unalias sed
	fi

	cd "${WORKDIR}/include"
	$(freebsd_get_bmake) CC="$(tc-getCC)" || die "make include failed"

	use crosscompile_opts_headers-only && return 0

	# Bug #270098
	append-flags $(test-flags -fno-strict-aliasing)

	# strip flags and do not do it later, we only add safe, and in fact
	# needed flags after all
	strip-flags
	export NOFLAGSTRIP=yes
	if [ "${CTARGET}" != "${CHOST}" ]; then
		export YACC='yacc -by'
		CHOST=${CTARGET} tc-export CC LD CXX RANLIB
		mymakeopts="${mymakeopts} NLS="
		append-flags "-isystem /usr/${CTARGET}/usr/include"
		append-ldflags "-L${WORKDIR}/lib/libc"

		bootstrap_csu

		bootstrap_libssp_nonshared

		SUBDIRS="${NON_NATIVE_SUBDIRS}"
	else
		# Forces to use the local copy of headers with USE=build as they might
		# be outdated in the system. Assume they are fine otherwise.
		use build && append-flags "-isystem '${WORKDIR}/include_proper'"

		use build && bootstrap_csu
		use build && bootstrap_libssp_nonshared

		SUBDIRS="${NATIVE_SUBDIRS}"
	fi

	export RAW_LDFLAGS=$(raw-ldflags)

	# Everything is now setup, build it!
	for i in ${SUBDIRS} ; do
		cd "${WORKDIR}/${i}/" || die "missing ${i}."
		freebsd_src_compile || die "make ${i} failed"
	done
}

gen_libc_ldscript() {
	# Parameters:
	#   $1 = target libdir
	#   $2 = source libc dir
	#   $3 = source libssp_nonshared dir

	# Clear the symlink.
	rm -f "${D}/$2/libc.so" || die

	# Move the library if needed
	if [ "$1" != "$2" ] ; then
		mv "${D}/$2/libc.so.7" "${D}/$1/" || die
	fi

	# Generate libc.so ldscript for inclusion of libssp_nonshared.a when linking
	# this is done to avoid having to touch gcc spec file as it is currently
	# done on FreeBSD upstream, mostly because their binutils aren't able to
	# cope with linker scripts yet.
	# Taken from toolchain-funcs.eclass:
	local output_format
	output_format=$($(tc-getCC) ${CFLAGS} ${LDFLAGS} -Wl,--verbose 2>&1 | sed -n 's/^OUTPUT_FORMAT("\([^"]*\)",.*/\1/p')
	[[ -n ${output_format} ]] && output_format="OUTPUT_FORMAT ( ${output_format} )"

	cat > "${D}/$2/libc.so" <<-END_LDSCRIPT
/* GNU ld script
   SSP (-fstack-protector) requires __stack_chk_fail_local to be local.
   GCC invokes this symbol in a non-PIC way, which results in TEXTRELs if
   this symbol was provided by a shared libc. So we link in
   libssp_nonshared.a from here.
 */
${output_format}
GROUP ( /$1/libc.so.7 /$3/libssp_nonshared.a )
END_LDSCRIPT
}

src_install() {
	[ "${CTARGET}" = "${CHOST}" ] \
		&& INCLUDEDIR="/usr/include" \
		|| INCLUDEDIR="/usr/${CTARGET}/usr/include"
	dodir ${INCLUDEDIR}
	einfo "Installing for ${CTARGET} in ${CHOST}.."
	install_includes ${INCLUDEDIR}

	use crosscompile_opts_headers-only && return 0
	local mylibdir=$(get_libdir)

	if [ "${CTARGET}" != "${CHOST}" ]; then
		mymakeopts="${mymakeopts} NO_MAN= \
			INCLUDEDIR=/usr/${CTARGET}/usr/include \
			SHLIBDIR=/usr/${CTARGET}/usr/lib \
			LIBDIR=/usr/${CTARGET}/usr/lib"
		SUBDIRS="$(get_csudir $(tc-arch-kernel ${CTARGET})) ${NON_NATIVE_SUBDIRS}"

		dosym "usr/include" "/usr/${CTARGET}/sys-include"
	else
		# Set SHLIBDIR and LIBDIR for multilib
		mymakeopts="${mymakeopts} SHLIBDIR=/usr/${mylibdir} LIBDIR=/usr/${mylibdir}"
		SUBDIRS="${NATIVE_SUBDIRS}"
	fi

	for i in ${SUBDIRS} ; do
		cd "${WORKDIR}/${i}/" || die "missing ${i}."
		freebsd_src_install || die "Install ${i} failed"
	done

	# Don't install the rest of the configuration files if crosscompiling
	if [ "${CTARGET}" != "${CHOST}" ] ; then
		# This is to get it stripped with the correct tools, otherwise it gets
		# stripped with the host strip.
		# And also get the correct OUTPUT_FORMAT in the libc ldscript.
		export CHOST=${CTARGET}
		gen_libc_ldscript "usr/${CTARGET}/usr/lib" "usr/${CTARGET}/usr/lib" "usr/${CTARGET}/usr/lib"
		return 0
	fi

	cd "${WORKDIR}/etc/"
	insinto /etc
	doins auth.conf nls.alias mac.conf netconfig

	# Install ttys file
	local MACHINE="$(tc-arch-kernel)"
	doins "etc.${MACHINE}"/*

	# Generate ldscripts for core libraries that will go in /
	gen_usr_ldscript -a alias cam geom ipsec jail kiconv \
		kvm m md procstat sbuf thr ufs util

	gen_libc_ldscript "${mylibdir}" "usr/${mylibdir}" "usr/${mylibdir}"

	# Install a libusb.pc for better compat with Linux's libusb
	if use usb ; then
		dodir /usr/$(get_libdir)/pkgconfig
		sed -e "s:@LIBDIR@:/usr/$(get_libdir):" "${FILESDIR}/libusb.pc.in" > "${D}/usr/$(get_libdir)/pkgconfig/libusb.pc" || die
	fi
}

install_includes()
{
	local INCLUDEDIR="$1"

	# The idea is to be called from either install or unpack.
	# During unpack it's required to install them as portage's user.
	if [[ "${EBUILD_PHASE}" == "install" ]]; then
		local DESTDIR="${D}"
		BINOWN="root"
		BINGRP="wheel"
	else
		local DESTDIR="${WORKDIR}"
		[[ -z "${USER}" ]] && USER="portage"
		BINOWN="${USER}"
		[[ -z "${GROUPS}" ]] && GROUPS="portage"
		BINGRP="${GROUPS}"
	fi

	# This is for ssp/ssp.h.
	einfo "Building ssp.h"
	cd "${WORKDIR}/gnu/lib/libssp/" || die "missing libssp"
	$(freebsd_get_bmake) ssp.h || die "problem building ssp.h"

	# Must exist before we use it.
	[[ -d "${DESTDIR}${INCLUDEDIR}" ]] || die "dodir or mkdir ${INCLUDEDIR} before using install_includes."
	cd "${WORKDIR}/include"

	local MACHINE="$(tc-arch-kernel)"

	einfo "Installing includes into ${INCLUDEDIR} as ${BINOWN}:${BINGRP}..."
	$(freebsd_get_bmake) installincludes \
		MACHINE=${MACHINE} DESTDIR="${DESTDIR}" \
		INCLUDEDIR="${INCLUDEDIR}" BINOWN="${BINOWN}" \
		BINGRP="${BINGRP}" || die "install_includes() failed"
	einfo "includes installed ok."
	EXTRA_INCLUDES="gnu/lib/libssp lib/librtld_db lib/libutil lib/msun gnu/lib/libregex"
	for i in $EXTRA_INCLUDES; do
		einfo "Installing $i includes into ${INCLUDEDIR} as ${BINOWN}:${BINGRP}..."
		cd "${WORKDIR}/$i" || die
		$(freebsd_get_bmake) installincludes DESTDIR="${DESTDIR}" \
			MACHINE=${MACHINE} MACHINE_ARCH=${MACHINE} \
			INCLUDEDIR="${INCLUDEDIR}" BINOWN="${BINOWN}" \
			BINGRP="${BINGRP}" || die "problem installing $i includes."
		einfo "$i includes installed ok."
	done
}
