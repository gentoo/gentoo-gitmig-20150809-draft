# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bootstrap_cmds/bootstrap_cmds-44.ebuild,v 1.5 2004/09/27 20:03:14 kito Exp $

DESCRIPTION="Darwin bootstrap_cmds - config, decomment, mig, relpath"
HOMEPAGE="http://darwinsource.opendarwin.org/10.3.5/"
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

pkg_setup() {
	export RC_OS=macos
	export RC_ARCHS=${BUILDARCHS}
	export TARGETS=${BUILDARCHS}
	export SRCROOT=${S}
	export OBJROOT=${WORKDIR}/build/obj
	export DSTROOT=${D}
	export SYMROOT=${WORKDIR}/build/sym
	export RC_CFLAGS="${CFLAGS}"
}

src_unpack() {
	unpack ${A}
	mkdir -p ${WORKDIR}/build/obj ${WORKDIR}/build/sym ${S}/BUILD
	rm ${S}/Makefile.postamble
	rm ${S}/config.tproj/Makefile.postamble
	rm ${S}/decomment.tproj/Makefile.postamble
	rm ${S}/relpath.tproj/Makefile.postamble
}

src_compile() {
	emake || die "make failed"
}

src_install() {
	make install DSTROOT=${S}/BUILD || die "make install failed"

	newbin ${S}/migcom.tproj/mig.sh mig || die "newbin mig failed"
	newbin ${S}/vers_string.sh vers_string || die "newbin vers_string failed"
	dobin ${S}/BUILD/usr/local/bin/{decomment,relpath} ${S}/BUILD/usr/bin/config \
		|| die "dobin decomment, relpath, config failed"

	exeinto /usr/libexec
	doexe ${S}/BUILD/usr/libexec/migcom

	doman ${S}/vers_string.1
}