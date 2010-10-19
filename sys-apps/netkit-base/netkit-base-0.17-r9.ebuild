# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/netkit-base/netkit-base-0.17-r9.ebuild,v 1.1 2010/10/19 20:23:50 chainsaw Exp $

EAPI=2

inherit base

DESCRIPTION="Old-style inetd"
HOMEPAGE="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/"
SRC_URI="ftp://ftp.uk.linux.org/pub/linux/Networking/netkit/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""
PROVIDE="virtual/inetd"
EPATCH_SUFFIX="patch"
PATCHES=( "${FILESDIR}" )

src_configure() {
	./configure || die
	sed -e "s:^CFLAGS=.*:CFLAGS=${CFLAGS} -Wall -Wbad-function-cast -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes -Wmissing-declarations -Wnested-externs -Winline:" \
		MCONFIG > MCONFIG.new || die "Unable to set CFLAGS for build"
	sed -e "s:^LDFLAGS=.*:LDFLAGS=${LDFLAGS}:" \
		MCONFIG.new > MCONFIG || die "Unable to set LDFLAGS for build"
}

src_install() {
	sed -i \
		-e 's:in\.telnetd$:in.telnetd -L /usr/sbin/telnetlogin:' \
		etc.sample/inetd.conf

	dosbin inetd/inetd
	doman inetd/inetd.8
	newinitd "${FILESDIR}"/inetd.rc6 inetd

	dodoc BUGS ChangeLog README
	docinto samples ; dodoc etc.sample/*
}
