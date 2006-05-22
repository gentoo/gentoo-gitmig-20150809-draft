# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/fuse4bsd/fuse4bsd-0.3.0.ebuild,v 1.1 2006/05/22 12:43:53 flameeyes Exp $

inherit portability toolchain-funcs

DESCRIPTION="Fuse for FreeBSD"
HOMEPAGE="http://fuse4bsd.creo.hu/"
# -sbin is needed for getmntopts.c, hardcoding 6.1 is nasty but can't think of
# any better solution right now
SRC_URI="http://fuse4bsd.creo.hu/downloads/${P}.tar.gz
	mirror://gentoo/freebsd-sbin-6.1.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86-fbsd"
IUSE=""

DEPEND=">=sys-freebsd/freebsd-sources-6.0
	virtual/pmake"
RDEPEND="sys-fs/fuse"

src_unpack() {
	unpack ${A}
	cd ${S}
	cp ${ROOT}/usr/include/fuse/fuse_kernel.h fuse_module/
	cp ${WORKDIR}/sbin/mount/getmntopts.c mount_fusefs/
}

src_compile() {
	tc-export CC
	$(get_bmake) \
		KMODDIR=/boot/modules BINDIR=/usr/sbin MANDIR=/usr/share/man/man \
		MOUNT=${WORKDIR}/sbin/mount \
		|| die "$(get_bmake) failed"
}

src_install() {
	dodir /boot/modules
	$(get_bmake) \
		KMODDIR=/boot/modules BINDIR=/usr/sbin MANDIR=/usr/share/man/man \
		DESTDIR=${D} install \
		|| die "$(get_bmake) failed"

	for docdir in ./ ./plaintext_out ./html_chunked_out ./html_aux; do
		docinto ${docdir}
		dodoc doc/${docdir}/*
	done
}
