# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cmucl-bin/cmucl-bin-18d.ebuild,v 1.3 2002/07/13 18:55:17 george Exp $

DESCRIPTION="CMUCL Lisp. This conforms to the ANSI Common Lisp Standard"
HOMEPAGE="http://www.cons.org/cmucl/index.html"
LICENSE="PD"
DEPEND=""
RDEPEND="$DEPEND"
SLOT="0"
SRC_ROOT="ftp://ftp.cn.freebsd.org/pub/cmucl/release/18d/"
SRC_URI="$SRC_ROOT/cmucl-18d-x86-linux.tar.bz2
	$SRC_ROOT/cmucl-18d-x86-linux.extra.tar.bz2"
S=${WORKDIR}
KEYWORDS="x86"

src_install () {
	patch -p1 < ${FILESDIR}/wrapper.patch || die "Failed to apply patch"
	into /opt/cmucl  || die
	dobin bin/*  || die
	dodoc doc/cmucl/*  || die
	find lib -type f | xargs dolib || die
	mv lib/cmucl/sample-wrapper cmucl || die "Failed to copy wrapper script"
	exeinto /usr/bin
	doexe cmucl || die "Failed to insert executable"

	#some tweaks to make it actually work; details in #4756
	dosym /opt/cmucl/lib /opt/cmucl/lib/subsystems
	fperms 755 /opt/cmucl/lib/motifd
	fperms 755 /opt/cmucl/lib/config
	#add short README on necessary environment for config
	dodoc ${FILESDIR}/README.config
}

