# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mmsclient/mmsclient-0.0.3-r1.ebuild,v 1.4 2004/05/06 20:44:56 vapier Exp $

inherit eutils

DESCRIPTION="mms protocol download utility"
HOMEPAGE="http://www.geocities.com/majormms/"
SRC_URI="http://www.geocities.com/majormms/mms_client-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND="virtual/glibc
	sys-devel/gcc
	sys-devel/automake
	sys-devel/autoconf"
DEPEND="virtual/glibc"

S=${WORKDIR}/mms_client-${PV}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PF}.patch
}

src_install() {
	emake DESTDIR=${D} install || die "make install failed"
}
