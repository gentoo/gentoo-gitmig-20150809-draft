# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/hwinfo/hwinfo-8.38.ebuild,v 1.2 2005/07/04 07:45:03 dholm Exp $

inherit eutils

DESCRIPTION="hwinfo is the hardware detection tool used in SuSE Linux."
HOMEPAGE="http://www.suse.com"
DEBIAN_PV="3"
SRC_URI="ftp://ftp.iqchoice.com/pub/people/rail/gmso/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
DEPEND="sys-fs/sysfsutils"

src_unpack (){
	unpack ${P}.tar.gz
	EPATCH_OPTS="-p1 -d ${S}" epatch ${FILESDIR}/${P}-makefile-fixes.patch
	sed -i -e "s,^LIBS[ \t]*= -lhd,LIBS = -lhd -lsysfs," ${S}/Makefile
	sed -i -e "s,^LIBDIR[ \t]*= /usr/lib$,LIBDIR = /usr/$(get_libdir)," ${S}/Makefile
}

src_compile(){
	# build is NOT parallel safe
	emake -j1 EXTRA_FLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc VERSION README COPYING ChangeLog
	doman doc/hwinfo.8
	# this is the SuSE version
	# somebody needs to port it still
	rm ${D}/etc/init.d/hwscan
}
