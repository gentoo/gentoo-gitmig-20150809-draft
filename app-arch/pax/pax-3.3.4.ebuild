# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pax/pax-3.3.4.ebuild,v 1.2 2003/12/04 09:15:32 seemant Exp $

inherit rpm

MY_PS=${P%.*}-${PV##*.}ras
MY_P=${P%.*}
S=${WORKDIR}/${MY_P}
DESCRIPTION="pax (Portable Archive eXchange is the POSIX standard archive tool."
HOMEPAGE="http://www.openbsd.org/cgi-bin/cvsweb/src/bin/pax/"
SRC_URI="ftp://rpmfind.net/linux/contrib/libc6/SRPMS/${MY_PS}.src.rpm"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm ~amd64 ~ia64"

DEPEND="virtual/glibc
	app-arch/rpm2targz"

src_unpack() {
	rpm_src_unpack
	cd ${MY_P}
	epatch ${WORKDIR}/pax-3.3-gcc.patch
	epatch ${WORKDIR}/pax-3.3-modifyWarn.patch
	epatch ${WORKDIR}/pax-3.3-doc.patch
	epatch ${WORKDIR}/pax-3.3-bzip2.patch
}

src_compile () {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	dobin src/pax
	doman src/pax.1
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
