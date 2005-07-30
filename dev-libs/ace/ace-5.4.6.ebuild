# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/ace/ace-5.4.6.ebuild,v 1.1 2005/07/30 01:52:58 dragonheart Exp $

inherit eutils

S=${WORKDIR}/ACE_wrappers
DESCRIPTION="The Adaptive Communications Environment"
SRC_URI="http://deuce.doc.wustl.edu/old_distribution/ACE-${PV}.tar.bz2"
HOMEPAGE="http://www.cs.wustl.edu/~schmidt/ACE.html"

SLOT="0"
LICENSE="BSD as-is"
KEYWORDS="~x86 ~sparc ~ppc ~alpha ~amd64"
IUSE="ipv6"

DEPEND="virtual/libc
	X? ( virtual/x11 )"

RDEPEND="${DEPEND}"

src_compile() {
	export ACE_ROOT=${S}
	mkdir build
	cd build
	ECONF_SOURCE=${S}
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
	emake ACE_ROOT=${S} DESTDIR=${D} install || die "failed to install"
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
