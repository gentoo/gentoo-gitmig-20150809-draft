# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

DESCRIPTION="Darwin bootstrap_cmds - config, decomment, mig, relpath,"
WEBPAGE="http://darwinsource.opendarwin.org/10.3.5/"
SRC_URI="http://darwinsource.opendarwin.org/tarballs/apsl/${P}.tar.gz"

LICENSE="APSL-2"

SLOT="0"
KEYWORDS="~ppc-macos"
IUSE=""

DEPEND="virtual/libc"

##
# Setup the Darwin build environment
#=================================================================
# requires fat build tools
# use build && BUILDARCHS="ppc i386" || 

BUILDARCHS="ppc"

DontPutThatInGlobalScope () {

mkdir -p ${WORKDIR}/build/obj ${WORKDIR}/build/sym ${S}/BUILD
}

export RC_OS=macos
export RC_ARCHS=${BUILDARCHS}
export TARGETS=${BUILDARCHS}
export SRCROOT=${S}
export OBJROOT=${WORKDIR}/build/obj
export DSTROOT=${D}
export SYMROOT=${WORKDIR}/build/sym
export RC_CFLAGS="${CFLAGS}"

src_compile() {
	emake || die "make failed :("
}

src_install() {
	cd ${S}
	rm ${S}/Makefile.postamble
	rm ${S}/config.tproj/Makefile.postamble
	rm ${S}/decomment.tproj/Makefile.postamble
	rm ${S}/relpath.tproj/Makefile.postamble

	make install DSTROOT=${S}/BUILD

	dobin ${S}/BUILD/usr/bin/config
	newbin ${S}/migcom.tproj/mig.sh mig
	newbin ${S}/vers_string.sh vers_string
	dobin ${S}/BUILD/usr/local/bin/decomment
	dobin ${S}/BUILD/usr/local/bin/relpath

	exeinto /usr/libexec
	doexe ${S}/BUILD/usr/libexec/migcom

	cd ${S}
	doman ${S}/vers_string.1
}
