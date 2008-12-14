# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ace/ace-5.6.5-r2.ebuild,v 1.1 2008/12/14 11:56:46 mrness Exp $

inherit toolchain-funcs eutils

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
	X? ( x11-libs/libXt x11-libs/libXaw )"

DEPEND="${COMMON_DEPEND}
	X? ( x11-proto/xproto )"

S="${WORKDIR}/ACE_wrappers"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/ace-missing-refcountable-header.patch
}

src_compile() {
	export ACE_ROOT="${S}"
	mkdir build
	cd build

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
	doins \
		"${S}/ace/Svc_Conf_Token_Table.h" \
		"${S}/ace/Unbounded_Set_Ex.inl" \
		"${S}/ace/Unbounded_Set_Ex.h" \
		"${S}/ace/Unbounded_Set_Ex.cpp"
	# punt gperf stuff
	rm -rf "${D}/usr/bin" "${D}/usr/share"
	# remove PACKAGE_* definitions from installed config.h (#192676)
	sed -i -e "s:^[ \t]*#define[ \t]\+PACKAGE_.*$:/\* & \*/:g" "${D}/usr/include/ace/config.h"
}

src_test() {
	cd "${S}/build"
	emake ACE_ROOT="${S}" check || die "self test failed"
}

pkg_postinst() {

	local CC_MACHINE=$($(tc-getCC) -dumpmachine)
	if [ -d "/usr/$(get_libdir)/gcc-lib/${CC_MACHINE}/$(gcc-fullversion)/include/ace" ]; then
	ewarn "moving /usr/$(get_libdir)/gcc-lib/${CC_MACHINE}/$(gcc-fullversion)/include/ace to"
	ewarn "ace.old"
	ewarn "This is required, as anything trying to compile against ACE will"
	ewarn "have problems with conflicting OS.h files if this is not done."
		mv "/usr/$(get_libdir)/gcc-lib/${CC_MACHINE}/$(gcc-fullversion)/include/ace" \
			"/usr/$(get_libdir)/gcc-lib/${CC_MACHINE}/$(gcc-fullversion)/include/ace.old"
	fi
}
