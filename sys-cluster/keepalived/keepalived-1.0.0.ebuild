# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/keepalived/keepalived-1.0.0.ebuild,v 1.2 2003/07/01 16:48:35 iggy Exp $

DESCRIPTION="The main goal of the keepalived project is to add a strong & robust keepalive facility to the Linux Virtual Server project."
HOMEPAGE="http://keepalived.sourceforge.net"
LICENSE="GPL-2"
DEPEND="popt"

SRC_URI="http://keepalived.sourceforge.net/software/${P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="x86"
S="${WORKDIR}/${P}"

src_compile() {
	cd "${S}"
	./configure --prefix=/
	make || die
}

src_install() {

	into /
	dosbin bin/keepalived

	into /
	dobin bin/genhash

	exeinto /etc/init.d
	newexe ${FILESDIR}/init-keepalived keepalived

	insinto /etc/keepalived
	doins keepalived/etc/keepalived/keepalived.conf

	insinto /etc/keepalived/samples
	doins keepalived/samples/client.pem
	doins keepalived/samples/dh1024.pem
	doins keepalived/samples/keepalived.conf.HTTP_GET.port
	doins keepalived/samples/keepalived.conf.SSL_GET
	doins keepalived/samples/keepalived.conf.SYNOPSIS
	doins keepalived/samples/keepalived.conf.ci-linux
	doins keepalived/samples/keepalived.conf.fwmark
	doins keepalived/samples/keepalived.conf.inhibit
	doins keepalived/samples/keepalived.conf.misc_check
	doins keepalived/samples/keepalived.conf.misc_check_arg
	doins keepalived/samples/keepalived.conf.real_server_group
	doins keepalived/samples/keepalived.conf.sample
	doins keepalived/samples/keepalived.conf.status_code
	doins keepalived/samples/keepalived.conf.virtualhost
	doins keepalived/samples/keepalived.conf.vrrp
	doins keepalived/samples/keepalived.conf.vrrp.lvs_syncd
	doins keepalived/samples/keepalived.conf.vrrp.scripts
	doins keepalived/samples/keepalived.conf.vrrp.sync
	doins keepalived/samples/root.pem
	doins keepalived/samples/sample.misccheck.smbcheck.sh

	dodoc ChangeLog COPYING README keepalived.spec
	einfo ""
	einfo "If you want Linux Virtual Server support in keepalived"
	einfo "then you must compile an LVS patched kernel, the ipvsadm"
	einfo "userland tools, and reemerge keepalived."
	einfo ""
}

