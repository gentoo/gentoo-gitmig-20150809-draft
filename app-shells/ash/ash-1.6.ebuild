# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/ash/ash-1.6.ebuild,v 1.1 2003/02/09 09:36:31 satai Exp $

inherit eutils

DESCRIPTION="NetBSD's lightweight bourne shell"
HOMEPAGE="http://cvsweb.netbsd.org/bsdweb.cgi/src/bin/sh/"
SRC_URI="ftp://ftp.netbsd.org/pub/NetBSD/NetBSD-release-1-6/tar_files/src/bin.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~x86"
IUSE=""
DEPEND="virtual/glibc
		sys-devel/pmake
		sys-apps/sed 
		dev-util/yacc"
S=${WORKDIR}/bin_NetBSD-1.6release/src/bin/sh

src_unpack() {
	mkdir ${WORKDIR}/bin_NetBSD-1.6release
	(cd ${WORKDIR}/bin_NetBSD-1.6release; tar zxv --no-same-owner \
	-f ${DISTDIR}/bin.tar.gz src/bin/sh)
	epatch ${FILESDIR}/dash-ash-hetio-yacc.diff
}
src_compile() {
	cd ${S}
	# pmake name conflicts, use full path
	/usr/bin/pmake CFLAGS:="-Wall -DBSD=1 -D_GNU_SOURCE -DGLOB_BROKEN \
	-DHAVE_VASPRINTF=1 -DIFS_BROKEN -DGCC_BROKEN_NG -D__COPYRIGHT\(x\)=\
	-D__RCSID\(x\)= -D_DIAGASSERT\(x\)= -g -O2 -fstrict-aliasing ${CFLAGS}" \
	YACC:="sh ${S}/yaccfe.sh" || die "pmake failed"
	cd -
}

src_install() {
	install -D -g root -m 0755 -o root -s ${S}/sh ${D}/bin/ash || {
		die "install failed."
	}
	install -D -g root -m 0644 -o root ${S}/sh.1 ${D}/usr/man/man1/ash.1 || {
		die "install failed."
	}
	gzip ${D}/usr/man/man1/ash.1
	dosym /usr/man/man1/ash.1.gz /usr/man/man1/sh.1.gz
}

