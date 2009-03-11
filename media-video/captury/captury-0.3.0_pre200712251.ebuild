# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/captury/captury-0.3.0_pre200712251.ebuild,v 1.3 2009/03/11 15:48:12 flameeyes Exp $

inherit multilib flag-o-matic eutils

DESCRIPTION="Captury Tool - captures the screen from your OpenGL games/applications."
HOMEPAGE="http://rm-rf.in/captury/"
SRC_URI="http://upstream.rm-rf.in/captury/captury-${PV}.tar.bz2"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug multilib"

RDEPEND=">=media-libs/libcaptury-0.3.0_pre200712251
		 x11-libs/libX11
		 amd64? ( multilib? ( app-emulation/emul-linux-x86-xlibs ) )
		 >=media-libs/libpng-1.2.14
		 virtual/opengl"

DEPEND="${RDEPEND}
		|| ( dev-libs/elfutils
			 dev-libs/libelf )
		dev-util/pkgconfig"

EMULTILIB_PKG="true"

S="${WORKDIR}/captury-${PV}/${PN}"

pkg_setup() {
	has_multilib_profile \
		&& built_with_use --missing die app-emulation/emul-linux-x86-xlibs opengl
}

setup_env() {
	myconf=""
	makeopts=""

	if [[ ${ABI} != ${DEFAULT_ABI} ]]; then
		# this is a workaround as Gentoo doesn't ship a 32bit version of libelf.so
		myconf="${myconf} --disable-builtin-strip-soname"
		makeopts="${makeopts} STRIP_SONAME=$(pwd)/../abi-${DEFAULT_ABI}/src/libGLcaptury/strip-soname"

		# unfortunately, different versions of emul-linux-x86-xlibs do install
		# their files into different locations, depending on what version you
		# installed.
		if [[ -x /emul/linux/x86/usr/lib/libGL.so ]]; then
			makeopts="${makeopts} NATIVE_LIBGL=/emul/linux/x86/usr/lib/libGL.so"
		else
			makeopts="${makeopts} NATIVE_LIBGL=/usr/$(get_libdir)/libGL.so"
		fi
		if [[ -x /emul/linux/x86/usr/lib/libX11.so ]]; then
			makeopts="${makeopts} NATIVE_LIBX11=/emul/linux/x86/usr/lib/libX11.so"
		else
			makeopts="${makeopts} NATIVE_LIBX11=/usr/$(get_libdir)/libX11.so"
		fi
	else
		makeopts="${makeopts} NATIVE_LIBGL=/usr/$(get_libdir)/libGL.so"
		makeopts="${makeopts} NATIVE_LIBX11=/usr/$(get_libdir)/libX11.so"
	fi

	export makeopts
	export myconf
}

src_compile() {
	if [[ -z ${OABI} ]] && has_multilib_profile; then
		use debug && append-flags -O0 -g3
		use debug || append-flags -DNDEBUG=1

		# fixes missing #define in libGLcaptury.cpp
		append-flags -DGLX_GLXEXT_PROTOTYPES

		einfo "Building multilib ${PN} for ABIs: $(get_install_abis)"
		OABI=${ABI}
		for ABI in $DEFAULT_ABI $(get_install_abis); do
			export ABI=${ABI}
			src_compile
		done
		ABI=${OABI}
		return
	fi

	cd "${S}"

	ABI=${ABI:-default}

	test -d abi-${ABI} && return

	if [[ ! -f configure ]]; then
		./autogen.sh || die "autogen.sh failed"
	fi

	mkdir abi-${ABI}
	cd abi-${ABI}

	einfo "Compiling for ABI ${ABI} ..."
	einfo

	setup_env

	../configure ${myconf} \
		--prefix="/usr" \
		--host="${CHOST}" \
		--sysconfdir="/etc" \
		--libdir="/usr/$(get_libdir)" \
		|| die "./configure for ABI ${ABI} failed"

	einfo "MAKE LINE: emake ${makeopts}"
	einfo
	emake ${makeopts} || die "make for ABI ${ABI} failed"
}

src_install() {
	for ABI in $(get_install_abis); do
		cd "${S}/abi-${ABI}"
		setup_env
		einfo "make ${makeopts} install DESTDIR=\"${D}\""
		make ${makeopts} install DESTDIR="${D}" || die "make install for ABI ${ABI} failed."
	done

	cd "${S}"

	dodoc AUTHORS ChangeLog* NEWS README* TODO
}

# vim:ai:noet:ts=4:nowrap
