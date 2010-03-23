# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/corosync/corosync-1.2.0.ebuild,v 1.1 2010/03/23 21:51:14 cardoe Exp $

EAPI=3

DESCRIPTION="Corosync Cluster Engine"
HOMEPAGE="http://corosync.org"
SRC_URI="ftp://ftp:downloads@ftp.corosync.org/downloads/${PN}-1.2.0/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+nss"

RDEPEND="nss? ( dev-libs/nss )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-apps/groff"

src_configure() {
	econf --disable-rdma $(use_enable nss) || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	rm "${D}"/etc/init.d/corosync
	newinitd "${FILESDIR}"/corosync.initd corosync
}
