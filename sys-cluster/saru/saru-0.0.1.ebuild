# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/saru/saru-0.0.1.ebuild,v 1.1 2004/08/31 15:49:44 tantive Exp $

DESCRIPTION="Heartbeat application to provide active active load balancers"

HOMEPAGE="http://www.ultramonkey.org/download/active_active/"
LICENSE="GPL-2"
DEPEND="virtual/glibc
    >=sys-cluster/ipvsadm
    >=dev-libs/popt 
    >=dev-libs/glib
    >=dev-libs/vanessa-logger-0.0.6
    >=net-libs/vanessa-socket-0.0.7
    >=dev-libs/vanessa-adt-0.0.6
    >=dev-libs/libip_vs_user_sync-1.0.0
    =sys-cluster/heartbeat-1.0.4*
    >=net-firewall/iptables"

SRC_URI="http://www.ultramonkey.org/download/active_active/${P}.tar.gz"
IUSE=""
SLOT="0"
KEYWORDS="~x86"
S="${WORKDIR}/${P}"

src_compile() {
    econf \
	--with-iptables-lib=/lib/iptables \
	--with-heartbeat-lib=/usr/lib/heartbeat \
	--with-heartbeat-fifo=/var/lib/heartbeat/api || die
	
    emake || die
}

src_install() {
    #einstall DESTDIR=${D} || die

    # saru binary
    dodir /usr/sbin
    exeinto /usr/sbin
    doexe saru/saru || die

    dodir /usr/lib/heartbeat
    dosym /usr/sbin/saru /usr/lib/heartbeat/saru || die

    # iptable module
    dodir /lib/iptables/
    insinto /lib/iptables/
    insopts -m0755
    doins iptables/extensions/libipt_saru.so || die

    dodir /lib/modules/${KV}/kernel/net/ipv4/netfilter
    insinto /lib/modules/${KV}/kernel/net/ipv4/netfilter
    doins iptables/kernel/ipt_saru.o || die

    dodir /etc/init.d /etc/conf.d /etc/saru
    insinto /etc/conf.d
    newins  ${FILESDIR}/saru.conf saru || die

    insinto /etc/saru
    doins etc/saru/saru.conf || die

    exeinto /etc/init.d
    newexe ${FILESDIR}/saru.init saru || die

    doman saru/saru.8 || die

    dodir /var/lib/heartbeat/api
    mknod -m 200 ${D}/var/lib/heartbeat/api/saru_1.req p || die
    fowners 65:65 /var/lib/heartbeat/api/saru_1.req || die
    mknod -m 600 ${D}/var/lib/heartbeat/api/saru_1.rsp p || die
    fowners 65:65 /var/lib/heartbeat/api/saru_1.rsp || die

    dodoc ChangeLog README INSTALL TODO NEWS AUTHORS || die
    dodoc patches/linux-2.4.20-outgoing_mac.hidden.patch \
	patches/linux-2.4.20-outgoing_mac.patch || die
    newdoc patches/README README.patches || die
}

pkg_postinst() {
    einfo ""
    einfo "upgrading module dependencies ... "
    /sbin/depmod -a -F /lib/modules/${KV}/build/System.map
    einfo "... done"
    einfo ""
    einfo "Please remember to re-emerge saru when you upgrade your kernel!"
    einfo ""
}
