# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cmucl-bin/cmucl-bin-18d.ebuild,v 1.1 2002/06/06 22:51:55 karltk Exp $

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

src_install () {
	patch -p1 < ${FILESDIR}/wrapper.patch || die "Failed to apply patch"
	into /opt/cmucl  || die
	dobin bin/*  || die
	dodoc doc/cmucl/*  || die
	find lib -type f | xargs dolib || die
	mv lib/cmucl/sample-wrapper cmucl || die "Failed to copy wrapper script"
	exeinto /usr/bin
	doexe cmucl || die "Failed to insert executable"
}

