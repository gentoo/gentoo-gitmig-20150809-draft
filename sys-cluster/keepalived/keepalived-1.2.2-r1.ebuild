# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/keepalived/keepalived-1.2.2-r1.ebuild,v 1.1 2011/06/08 05:44:11 robbat2 Exp $

EAPI=3

inherit flag-o-matic autotools base

DESCRIPTION="A strong & robust keepalive facility to the Linux Virtual Server project"
HOMEPAGE="http://www.keepalived.org/"
SRC_URI="http://www.keepalived.org/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE="debug"

RDEPEND="dev-libs/popt
	sys-apps/iproute2
	dev-libs/libnl
	dev-libs/openssl"
DEPEND="${RDEPEND}
	>=sys-kernel/linux-headers-2.6.30"

PATCHES=( "${FILESDIR}"/${PN}-1.1.20-do-not-need-kernel-sources.patch )

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_configure() {
	STRIP=/bin/true \
	econf \
		--enable-vrrp \
		$(use_enable debug)
}

src_install() {
	base_src_install

	newinitd "${FILESDIR}"/init-keepalived keepalived || die

	dodoc doc/keepalived.conf.SYNOPSIS || die
	dodoc README CONTRIBUTORS INSTALL VERSION ChangeLog AUTHOR TODO || die

	docinto genhash
	dodoc genhash/README genhash/AUTHOR genhash/ChangeLog genhash/VERSION || die
	# This was badly named by upstream, it's more HOWTO than anything else.
	newdoc INSTALL INSTALL+HOWTO || die

	# Security risk to bundle SSL certs
	rm -f "${D}"/etc/keepalived/samples/*.pem
	# Clean up sysvinit files
	rm -rf "${D}"/etc/sysconfig "${D}"/etc/rc.d/
}
