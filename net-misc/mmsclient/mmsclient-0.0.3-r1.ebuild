# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mmsclient/mmsclient-0.0.3-r1.ebuild,v 1.2 2004/04/27 21:41:48 agriffis Exp $

inherit eutils

include eutils

S=${WORKDIR}/mms_client-${PV}
DESCRIPTION="mms protocol download utility"
SRC_URI="http://www.geocities.com/majormms/mms_client-${PV}.tar.gz"
HOMEPAGE="http://www.geocities.com/majormms/"

DEPEND="virtual/glibc
	sys-devel/gcc
	sys-devel/automake
	sys-devel/autoconf"

DEPEND="virtual/glibc"

KEYWORDS="~x86 ~sparc "
LICENSE="GPL-2"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PF}.patch
}

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR=${D} install || die "make install failed"
	dodoc COPYING
}
