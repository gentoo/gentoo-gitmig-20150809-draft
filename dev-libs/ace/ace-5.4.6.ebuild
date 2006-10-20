# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ace/ace-5.4.6.ebuild,v 1.6 2006/10/20 00:10:23 kloeri Exp $

inherit eutils

S="${WORKDIR}/ACE_wrappers"
DESCRIPTION="The Adaptive Communications Environment"
SRC_URI="http://deuce.doc.wustl.edu/old_distribution/ACE-${PV}.tar.bz2"
HOMEPAGE="http://www.cs.wustl.edu/~schmidt/ACE.html"

SLOT="0"
LICENSE="BSD as-is"
KEYWORDS="alpha ~amd64 ppc sparc x86"
IUSE="X ipv6"

DEPEND="dev-libs/openssl"

RDEPEND="${DEPEND}
	X? ( || (
	( x11-libs/libXt
	x11-libs/libXaw )
	virtual/x11 )
	)"

DEPEND="${DEPEND}
	X? ( || (
	( x11-proto/xproto )
	virtual/x11 )
	)"

src_compile() {
	export ACE_ROOT="${S}"
	mkdir build
	cd build
	ECONF_SOURCE="${S}"
	econf --enable-lib-all $(use_with X) $(use_enable ipv6)
	# --with-qos needs ACE_HAS_RAPI
	emake static_libs=1 || die
}


src_test() {
	#cd ${S}/build
	#make ACE_ROOT=${S} check || die "self test failed"
	einfo "src_test currently stalls after Process_Mutex_Test"
}

src_install() {
	cd build
	make ACE_ROOT="${S}" DESTDIR="${D}" install || die "failed to install"
}


pkg_postinst() {
	# This is required, as anything trying to compile against ACE will have
	# problems with conflicting OS.h files if this is not done.

	local CC_MACHINE=`gcc -dumpmachine`
	local CC_VERSION=`gcc -dumpversion`
	if [ -d "/usr/lib/gcc-lib/${CC_MACHINE}/${CC_VERSION}/include/ace" ]; then
		mv "/usr/lib/gcc-lib/${CC_MACHINE}/${CC_VERSION}/include/ace" \
			"/usr/lib/gcc-lib/${CC_MACHINE}/${CC_VERSION}/include/ace.old"
	fi
}
