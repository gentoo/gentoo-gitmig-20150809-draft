# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/chuck/chuck-1.2.1.1.ebuild,v 1.3 2008/05/04 15:23:37 maekke Exp $

inherit toolchain-funcs flag-o-matic eutils

DESCRIPTION="Strongly-timed, Concurrent, and On-the-fly
Audio Programming Language"
HOMEPAGE="http://chuck.cs.princeton.edu/release/"
SRC_URI="http://chuck.cs.princeton.edu/release/files/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="oss jack alsa examples"

RDEPEND="jack? ( media-sound/jack-audio-connection-kit )
	alsa? ( >=media-libs/alsa-lib-0.9 )
	media-libs/libsndfile"
DEPEND="${RDEPEND}
	sys-devel/bison
	sys-devel/flex"

pkg_setup() {
	local cnt=0
	use jack && cnt="$((${cnt} + 1))"
	use alsa && cnt="$((${cnt} + 1))"
	use oss && cnt="$((${cnt} + 1))"
	if [[ "${cnt}" -eq 0 ]] ; then
		eerror "One of the following USE flags is needed: jack, alsa or oss"
		die "Please set one audio engine type"
	elif [[ "${cnt}" -ne 1 ]] ; then
		ewarn "You have set ${P} to use multiple audio engine."
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-hid-smc.patch"
	epatch "${FILESDIR}/${P}-gcc43.patch"
}

src_compile() {
	local backend
	if use jack ; then
		backend="jack"
	elif use alsa ; then
		backend="alsa"
	elif use oss ; then
		backend="oss"
	fi
	einfo "Compiling against ${backend}"

	# when compile with athlon or athlon-xp flags
	# chuck crashes on removing a shred with a double free or corruption
	# it happens in Chuck_VM_Stack::shutdown() on the line
	#   SAFE_DELETE_ARRAY( stack );
	replace-cpu-flags athlon athlon-xp i686

	cd "${S}/src"
	emake -f "makefile.${backend}" CC=$(tc-getCC) CXX=$(tc-getCXX) || die "emake failed"
}

src_install() {
	dobin src/chuck

	dodoc AUTHORS DEVELOPER PROGRAMMER QUICKSTART README THANKS TODO VERSIONS
	docinto doc
	dodoc doc/*
	if use examples; then
		insinto /usr/share/doc/${P}/examples
		doins `find examples -type f`
		for dir in `find examples/* -type d`; do
			insinto /usr/share/doc/${P}/$dir
			doins $dir/*
		done
	fi
}
