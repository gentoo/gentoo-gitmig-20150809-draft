# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/idmapd/idmapd-1.5.ebuild,v 1.3 2004/06/08 17:58:24 vapier Exp $

inherit eutils

DESCRIPTION="NFSv4 ID <-> name mapping daemon"
HOMEPAGE="http://www.citi.umich.edu/projects/nfsv4/nfsv4-linux/"
SRC_URI="http://www.citi.umich.edu/projects/nfsv4/nfsv4-linux/idmapd/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~arm ~hppa ~amd64 ~ppc64 ~s390"
IUSE=""

DEPEND="dev-libs/libevent"

src_unpack() {
	unpack ${A}
	cd ${S}
	rm -rf libevent-0.6/*
	echo 'all:'$'\n''install:' > libevent-0.6/Makefile
	sed -i "s:-g \$(AM_CFLAGS) -Ilibevent-0\.6:@CFLAGS@:" Makefile.in
	epatch ${FILESDIR}/${PV}-no-string.patch
}

src_compile() {
	econf --bindir=/sbin || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	exeinto /etc/init.d ; newexe ${FILESDIR}/idmapd.rc idmapd || die
	insinto /etc/conf.d ; newins ${FILESDIR}/idmapd.confd idmapd || die
}
