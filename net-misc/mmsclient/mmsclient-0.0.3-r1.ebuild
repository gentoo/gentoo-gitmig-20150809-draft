# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mmsclient/mmsclient-0.0.3-r1.ebuild,v 1.7 2005/07/31 03:51:25 vanquirius Exp $

inherit eutils

DESCRIPTION="mms protocol download utility"
HOMEPAGE="http://www.geocities.com/majormms/"
SRC_URI="http://www.geocities.com/majormms/mms_client-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE=""

DEPEND="virtual/libc
	sys-devel/gcc
	sys-devel/automake
	sys-devel/autoconf"
DEPEND="virtual/libc"

S=${WORKDIR}/mms_client-${PV}

src_unpack() {
	unpack ${A}; cd ${S}
	epatch ${FILESDIR}/${PF}.patch
	epatch ${FILESDIR}/${P}-fbsd.patch
}

src_install() {
	make DESTDIR=${D} install || die
}
