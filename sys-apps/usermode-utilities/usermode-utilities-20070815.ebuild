# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/usermode-utilities/usermode-utilities-20070815.ebuild,v 1.7 2009/05/14 08:48:12 fauli Exp $

inherit eutils

DESCRIPTION="Tools for use with Usermode Linux virtual machines"
SRC_URI="http://user-mode-linux.sourceforge.net/uml_utilities_${PV}.tar.bz2"
HOMEPAGE="http://user-mode-linux.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-* ~amd64 x86"
IUSE=""

RDEPEND="sys-fs/fuse"
DEPEND="${RDEPEND}
	virtual/libc"

S="${WORKDIR}"/tools-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-20060216-unlazy.patch
	epatch "${FILESDIR}"/${P}-nostrip.patch
	sed -i -e 's:-o \$(BIN):$(LDFLAGS) -o $(BIN):' "${S}"/*/Makefile || die "LDFLAGS sed failed"
	sed -i -e 's:-o \$@:$(LDFLAGS) -o $@:' "${S}"/moo/Makefile || die "LDFLAGS sed (moo) failed"
}

src_compile() {
	emake CFLAGS="${CFLAGS} -DTUNTAP -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE -g -Wall" all || die "Compilation failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
}
