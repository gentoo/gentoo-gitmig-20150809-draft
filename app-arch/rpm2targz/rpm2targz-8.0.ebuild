# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm2targz/rpm2targz-8.0.ebuild,v 1.23 2005/01/01 11:57:15 eradicator Exp $

inherit gcc

DESCRIPTION="Convert a .rpm file to a .tar.gz archive"
HOMEPAGE="http://www.slackware.com/config/packages.php"
SRC_URI="ftp://ftp.slackware.com/pub/slackware/slackware-${PV}/source/a/bin/rpm2targz
	ftp://ftp.slackware.com/pub/slackware/slackware-${PV}/source/a/bin/rpmoffset.c
	ftp://ftp.slackware.com/pub/slackware/slackware-${PV}/source/a/bin/rpm2targz.README"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa amd64"
IUSE=""

DEPEND="virtual/libc
	app-arch/cpio"

src_unpack() {
	cd ${WORKDIR} && mkdir ${P}
	cp ${DISTDIR}/rpm2targz ${S}
	cp ${DISTDIR}/rpm2targz.README ${S}
	cp ${DISTDIR}/rpmoffset.c ${S}
}

src_compile() {
	$(gcc-getCC) ${CFLAGS} -o rpmoffset rpmoffset.c || die
}

src_install() {
	dobin rpmoffset rpm2targz || die
	dodoc rpm2targz.README
}
