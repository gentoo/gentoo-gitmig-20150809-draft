# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/heartbeat/heartbeat-1.1.3.ebuild,v 1.3 2003/11/21 17:55:51 iggy Exp $

DESCRIPTION="Heartbeat high availability cluster manager"
HOMEPAGE="http://www.linux-ha.org"
SRC_URI="http://www.linux-ha.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 mips"

DEPEND="dev-libs/popt
	dev-libs/glib
	net-libs/libnet"

src_unpack() {
	unpack ${A}
	cd ${S}
	mv ltmain.sh ltmain.orig
	echo "export _POSIX2_VERSION=199209" > ltmain.sh
	cat ltmain.orig >> ltmain.sh
}

src_compile() {
	./configure --prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--with-group-name=cluster \
		--with-group-id=65 \
		--with-ccmuser-name=cluster \
		--with-ccmuser-id=65 || die
	emake || die
}

pkg_preinst() {
	# check for cluster group, if it doesn't exist make it
	if ! grep -q cluster.*65 /etc/group ; then
		groupadd -g 65 cluster
	fi
	# check for cluster user, if it doesn't exist make it
	if ! grep -q cluster.*65 /etc/passwd ; then
		useradd -u 65 -g cluster -s /dev/null -d /var/lib/heartbeat cluster
	fi
}

src_install() {
	make DESTDIR=${D} install || die
	exeinto /etc/init.d
	newexe ${FILESDIR}/heartbeat-init heartbeat
}
