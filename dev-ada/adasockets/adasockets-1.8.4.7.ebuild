# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ada/adasockets/adasockets-1.8.4.7.ebuild,v 1.2 2007/05/27 09:41:18 george Exp $

WANT_AUTOCONF="2.1"

inherit gnat autotools

DESCRIPTION="An Interface to BSD sockets from Ada (TCP, UDP and multicast)."
SRC_URI="http://www.rfc1149.net/download/adasockets/${P}.tar.gz"
HOMEPAGE="http://www.rfc1149.net/devel/adasockets/"
LICENSE="GMGPL"

DEPEND="virtual/gnat"

SLOT="0"
IUSE=""
KEYWORDS="~x86 ~amd64"


# a location to temporarily keep common stuff installed by make install
CommonInst="${WORKDIR}/common-install"

lib_compile() {
	econf || die "./configure failed"
	emake || die
}

lib_install() {
	mv ${SL}/src/sockets*.ali ${DL}
	mv src/.libs/libadasockets.a ${DL}
	mv src/.libs/libadasockets.so* ${DL}

	# move common stuff out of $DL
	if [[ ! -d "${CommonInst}" ]] ; then
		# we need only one copy, its all identical
		mkdir "${CommonInst}"
		mv ${SL}/src/*.ad? "${CommonInst}"
	fi
}

src_install() {
	# sources
	dodir   "${AdalibSpecsDir}/${PN}"
	insinto "${AdalibSpecsDir}/${PN}"
	doins "${CommonInst}"/sockets*.ad?

	# environment
	echo "ADA_OBJECTS_PATH=%DL%" > ${LibEnv}
	echo "ADA_INCLUDE_PATH=${AdalibSpecsDir}/${PN}" >> ${LibEnv}
	echo "LDPATH=%DL%" >> ${LibEnv}

	gnat_src_install

	# and docs
	dodoc AUTHORS COPYING INSTALL NEWS README doc/adasockets.ps
	doinfo doc/adasockets.info
	insinto /usr/share/doc/${PF}
	doins doc/adasockets.pdf
}
