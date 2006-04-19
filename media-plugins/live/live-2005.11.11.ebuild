# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/live/live-2005.11.11.ebuild,v 1.9 2006/04/19 23:48:07 tcort Exp $

inherit flag-o-matic eutils toolchain-funcs multilib

DESCRIPTION="Source-code libraries for standards-based RTP/RTCP/RTSP multimedia streaming, suitable for embedded and/or low-cost streaming applications"
HOMEPAGE="http://www.live555.com/"
SRC_URI="http://www.live555.com/liveMedia/public/${P/-/.}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE=""
KEYWORDS="alpha amd64 ~arm ~hppa ia64 ~mips ppc ppc64 sparc x86"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# -fPIC is needed on amd64 because some applications are using live
	# to make shared libraries, which wont work without -fPIC on that
	# arch. The build system used isn't advanced enough to easily
	# specify that the test programs dont need to be PIC themselves,
	# and makefiles are generated on the fly, so I'm adding it as a
	# global flag.
	# Travis Tilley <lv@gentoo.org> 09 Apr 2004
	use amd64 && append-flags -fPIC
	use ppc && append-flags -fPIC

	epatch ${FILESDIR}/live-gcc41.patch

	# replace -O2 with MY_CFLAGS variable (do *not* use $CFLAGS here!)
	sed -i -e "s: -O2 : \$(MY_CFLAGS) :g" config.linux
}

src_compile() {
	./genMakefiles linux
	emake -j1 MY_CFLAGS="${CFLAGS}" CPLUSPLUS_COMPILER="$(tc-getCXX)" \
		C_COMPILER="$(tc-getCC)" LINK="$(tc-getCXX) -o" || die
}

src_install() {
	# no installer, go manual ...

	# find and install libraries, mplayer needs to find
	# each library in a subdirectory with same name as
	# the lib
	local lib dir
	for lib in $(find . -type f -name "*.a"); do
		dir="${lib/.\//}"
		dir="${dir%%/*}"
		insinto "/usr/$(get_libdir)/${PN}/${dir}"
		doins "${lib}"
		insinto "/usr/$(get_libdir)/${PN}/${dir}/include"
		doins "${dir}/include/"*h
	done

	# find and install test programs
	dobin $(find testProgs -type f -perm +111)

	# install docs
	dodoc README
}
