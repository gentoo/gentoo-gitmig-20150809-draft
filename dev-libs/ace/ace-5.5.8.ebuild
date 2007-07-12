# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ace/ace-5.5.8.ebuild,v 1.4 2007/07/12 22:00:32 dev-zero Exp $

inherit toolchain-funcs

DESCRIPTION="The Adaptive Communications Environment"
HOMEPAGE="http://www.cs.wustl.edu/~schmidt/ACE.html"
SRC_URI="!tao? ( http://download.dre.vanderbilt.edu/previous_versions/ACE-${PV}.tar.bz2 )
	tao? (
		!ciao? ( http://download.dre.vanderbilt.edu/previous_versions/ACE+TAO-${PV}.tar.bz2 )
		ciao? ( http://download.dre.vanderbilt.edu/previous_versions/ACE+TAO+CIAO-${PV}.tar.bz2 )
	)"
LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~amd64"
IUSE="X ipv6 tao ciao"

COMMON_DEPEND="dev-libs/openssl"
# TODO probably more
RDEPEND="${COMMON_DEPEND}
	X? ( || (
	( x11-libs/libXt
	x11-libs/libXaw )
	virtual/x11 )
	)"

DEPEND="${COMMON_DEPEND}
	X? ( || (
	( x11-proto/xproto )
	virtual/x11 )
	)"

S="${WORKDIR}/ACE_wrappers"

src_compile() {
	export ACE_ROOT="${S}"
	mkdir build
	cd build

	# This disables a silly test which fills the memory
	# waiting for a bad_alloc exception and happily
	# leaking memory (bug #169647)
	export ace_cv_new_throws_bad_alloc_exception="yes"

	ECONF_SOURCE="${S}"
	econf \
		--enable-lib-all \
		$(use_with X) \
		$(use_enable ipv6) \
		|| die "econf died"
	# --with-qos needs ACE_HAS_RAPI
	emake static_libs=1 || die "emake failed"
}

src_install() {
	cd build
	emake ACE_ROOT="${S}" DESTDIR="${D}" install || die "failed to install"
	insinto /usr/include/ace
	doins "${S}/ace/OS.inl"
	doins "${S}/ace/Select_Reactor.h"
	# punt gperf stuff
	rm -rf "${D}/usr/bin" "${D}/usr/share"
}

src_test() {
	cd "${S}/build"
	emake ACE_ROOT="${S}" check || die "self test failed"
}

pkg_postinst() {
	# This is required, as anything trying to compile against ACE will have
	# problems with conflicting OS.h files if this is not done.

	local CC_MACHINE=$($(tc-getCC) -dumpmachine)
	if [ -d "/usr/lib/gcc-lib/${CC_MACHINE}/$(gcc-fullversion)/include/ace" ]; then
		mv "/usr/lib/gcc-lib/${CC_MACHINE}/$(gcc-fullversion)/include/ace" \
			"/usr/lib/gcc-lib/${CC_MACHINE}/$(gcc-fullversion)/include/ace.old"
	fi
}
