# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/mount-cifs/mount-cifs-3.0.30.ebuild,v 1.9 2011/04/11 17:00:52 angelos Exp $

inherit toolchain-funcs

DESCRIPTION="cifs filesystem mount helper split from Samba"
HOMEPAGE="http://linux-cifs.samba.org/cifs/cifs_download.html"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="!<net-fs/samba-3.0.25"
RDEPEND="${DEPEND}"

src_compile() {
	cd "${S}/source/client"
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} mount.cifs.c -o mount.cifs || die "make mount.cifs failed"
	$(tc-getCC) ${CFLAGS} ${LDFLAGS} umount.cifs.c -o umount.cifs || die "make umount.cifs failed"
}

src_install() {
	dobin source/client/{mount,umount}.cifs || die
	dosym /usr/bin/mount.cifs /sbin/mount.cifs

	docinto html
	dohtml docs/htmldocs/*
	doman docs/manpages/{mount,umount}.cifs.8
}
