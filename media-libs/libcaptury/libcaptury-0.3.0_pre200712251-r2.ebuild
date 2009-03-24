# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcaptury/libcaptury-0.3.0_pre200712251-r2.ebuild,v 1.3 2009/03/24 03:13:57 jer Exp $

inherit multilib flag-o-matic

DESCRIPTION="Captury Framework Library"
HOMEPAGE="http://rm-rf.in/projects/captury/"
SRC_URI="http://upstream.rm-rf.in./captury/captury-${PV}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="debug multilib"

RDEPEND=">=media-libs/capseo-0.3.0_pre200712251
	x11-libs/libX11
	x11-libs/libXfixes
	virtual/opengl
	amd64? ( multilib? (
		>=app-emulation/emul-linux-x86-xlibs-20071114
		app-emulation/emul-linux-x86-medialibs
	) )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

EMULTILIB_PKG="true"

S="${WORKDIR}/captury-${PV}/${PN}"

pkg_setup() {
	# try to turn off distcc and ccache for people that have a problem with it
	export DISTCC_DISABLE=1
	export CCACHE_DISABLE=1
}

setup_env() {
	# workaround for users having FEATURES=ccache set, as ccache doesn't, play
	# nice to multilib builds (see bug 206822)
	filter-flags -DABI=*
	append-flags -DABI=${ABI}
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	if [[ ! -f configure ]]; then
		./autogen.sh || die "autogen.sh failed"
	fi
}

src_compile() {
	if [[ -z ${OABI} ]] && has_multilib_profile; then
		use debug && append-flags -O0 -g3
		use debug || append-flags -DNDEBUG=1

		einfo "Building multilib ${PN} for ABIs: $(get_install_abis)"
		OABI=${ABI}
		for ABI in $(get_install_abis); do
			export ABI=${ABI}
			src_compile
		done
		ABI=${OABI}
		return
	fi

	cd "${S}"

	ABI=${ABI:-default}

	setup_env

	mkdir abi-${ABI}
	cd abi-${ABI}

	../configure \
		--prefix="/usr" \
		--host="$(get_abi_CHOST ${ABI})" \
		--libdir="/usr/$(get_libdir)" \
		|| die "./configure for ABI ${ABI} failed"

	emake || die "make for ABI ${ABI} failed"
}

src_install() {
	for ABI in $(get_install_abis); do
		make -C abi-${ABI} install DESTDIR="${D}" || die "make install for ABI ${ABI} failed."
	done

	dodoc AUTHORS ChangeLog* NEWS README* TODO
}

# vim:ai:noet:ts=4:nowrap
