# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cmucl-bin/cmucl-bin-18d-r1.ebuild,v 1.1 2002/08/18 00:05:46 karltk Exp $

DESCRIPTION="CMUCL Lisp. This conforms to the ANSI Common Lisp Standard"
HOMEPAGE="http://www.cons.org/cmucl/index.html"
LICENSE="public-domain"
DEPEND=""
RDEPEND="$DEPEND"
SLOT="0"
SRC_URI="ftp://ftp.cn.freebsd.org/pub/cmucl/release/18d/cmucl-18d-x86-linux.tar.bz2
	ftp://ftp.cn.freebsd.org/pub/cmucl/release/18d/cmucl-18d-x86-linux.extra.tar.bz2"
S=${WORKDIR}/${P}
KEYWORDS="x86"

src_unpack() {
	mkdir ${P}
	cd ${P}
	unpack cmucl-18d-x86-linux.tar.bz2
	unpack cmucl-18d-x86-linux.extra.tar.bz2
	patch -p1 < ${FILESDIR}/${PV}/wrapper.patch || die "Failed to apply patch"
}

src_install () {
	into /opt/cmucl  || die
	dobin bin/*  || die
	dodoc doc/cmucl/*  || die
	find lib -type f | xargs dolib || die
	exeinto /usr/bin

	# 2002-08-18: karltk
	# Not quite happy with us naming it 'lisp'. We should
	# probably name it 'cmucl' and change the man pages.
	newexe lib/cmucl/sample-wrapper lisp

	#some tweaks to make it actually work; details in #4756
	dosym /opt/cmucl/lib /opt/cmucl/lib/subsystems
	fperms 755 /opt/cmucl/lib/motifd
	fperms 755 /opt/cmucl/lib/config
	#add short README on necessary environment for config
	dodoc ${FILESDIR}/README.config

	doman man/man1/*.1
}

