# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/pax/pax-3.3.4.ebuild,v 1.13 2006/07/03 01:40:30 vapier Exp $

inherit eutils rpm

MY_PS=${P%.*}-${PV##*.}ras
MY_P=${P%.*}
S=${WORKDIR}/${MY_P}
DESCRIPTION="pax (Portable Archive eXchange) is the POSIX standard archive tool"
HOMEPAGE="http://www.openbsd.org/cgi-bin/cvsweb/src/bin/pax/"
SRC_URI="ftp://rpmfind.net/linux/contrib/libc6/SRPMS/${MY_PS}.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86"
IUSE=""

DEPEND="app-arch/rpm2targz"

src_unpack() {
	rpm_src_unpack
	cd ${MY_P}
	epatch "${WORKDIR}"/pax-3.3-gcc.patch
	epatch "${WORKDIR}"/pax-3.3-modifyWarn.patch
	epatch "${WORKDIR}"/pax-3.3-doc.patch
	epatch "${WORKDIR}"/pax-3.3-bzip2.patch
}

src_install() {
	dobin src/pax || die
	doman src/pax.1
	dodoc AUTHORS ChangeLog NEWS README THANKS
}
