# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/fpc-source/fpc-source-1.9.5_pre20040820.ebuild,v 1.2 2004/08/21 18:18:46 chriswhite Exp $

inherit eutils

FPC_V="1.9.5"

DESCRIPTION="Source build for the Free Pascal Compiler"
HOMEPAGE="http://www.us.freepascal.org/fpc.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2
		doc? ( ftp://ftp.freepascal.org/pub/fpc/docs/doc-html.zip )"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"
DEPEND="!dev-lang/fpc"
S=${WORKDIR}/fpc-${FPC_V}

src_compile() {
	cd ${S}

	einfo "Building the fpc compiler and units"
	emake \
	build \
	OS_TARGET=linux \
	PP=${S}/ppc386 \
	PREFIX=${D}/usr \
	|| die "Free Pascal Compiler build process failed!"
}

src_install() {

	einfo "Installing the fpc compiler and units"
	emake \
	install \
	OS_TARGET=linux \
	PP=${S}/ppc386 \
	PREFIX=${D}/usr \
	|| die "Free Pascal Compiler install failed!"

	if use doc
	then
		#install the html docs
		einfo "Installing html docs"
		mkdir ${D}/usr/share/doc/fpc-${FPC_V}/html
		cp -r ${WORKDIR}/doc/* ${D}/usr/share/doc/fpc-${FPC_V}/html
	fi
}

config() {
	#Create our configuration file so fpc
	#is easier to use
	/usr/lib/fpc/${FPC_V}/samplecfg /usr/lib/fpc/${FPC_V} /etc

	einfo "The configuration file for fpc has been placed in /etc/fpc.cfg"
	einfo "Use this to customize your pascal compile flags"
	einfo "More information on the fpc flags can be found in the fpc manpage"
	echo
	einfo "Examples and docs can be found in /usr/share/doc/fpc-${FPC_V}"
	einfo "Upstream support can be found at: http://community.freepascal.org:10000/"
}
