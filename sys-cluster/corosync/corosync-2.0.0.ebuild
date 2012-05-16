# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/corosync/corosync-2.0.0.ebuild,v 1.1 2012/05/16 12:39:47 ultrabug Exp $

EAPI=4

inherit autotools base

DESCRIPTION="OSI Certified implementation of a complete cluster engine"
HOMEPAGE="http://www.corosync.org/"
SRC_URI="ftp://ftp:${PN}.org@${PN}.org/downloads/${P}/${P}.tar.gz"

LICENSE="BSD-2 public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc infiniband static-libs"

# TODO: support those new configure flags
# --enable-watchdog : Watchdog support
# --enable-augeas : Install the augeas lens for corosync.conf
# --enable-snmp : SNMP protocol support
# --enable-xmlconf : XML configuration support
# --enable-systemd : Install systemd service files
RDEPEND="!sys-cluster/heartbeat
	infiniband? (
		sys-infiniband/libibverbs
		sys-infiniband/librdmacm
	)
	dev-libs/nss
	sys-cluster/libqb"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( sys-apps/groff )"

PATCHES=(
	"${FILESDIR}/${PN}-2.0.0-docs.patch"
	"${FILESDIR}/${PN}-2.0.0-rpath.patch"
)

DOCS=( README.recovery SECURITY TODO AUTHORS )

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_configure() {
	# appends lib to localstatedir automatically
	# FIXME: install just shared libs --disable-static does not work
	econf \
		--localstatedir=/var \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable doc) \
		$(use_enable infiniband rdma)
}

src_compile() {
	# Fix parallel compilation problem with libcmap
	MAKEOPTS="-j1" base_src_compile
}

src_install() {
	default
	newinitd "${FILESDIR}"/${PN}.initd ${PN}

	insinto /etc/logrotate.d
	newins "${FILESDIR}"/${PN}.logrotate ${PN}

	keepdir /var/lib/corosync
	use static-libs || rm -rf "${D}"/usr/$(get_libdir)/*.a || die
}
