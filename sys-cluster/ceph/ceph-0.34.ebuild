# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ceph/ceph-0.34.ebuild,v 1.1 2011/08/31 17:29:31 alexxy Exp $

EAPI="3"

inherit autotools eutils multilib

DESCRIPTION="Ceph distributed filesystem"
HOMEPAGE="http://ceph.newdream.net/"
SRC_URI="http://ceph.newdream.net/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug fuse gtk libatomic radosgw static-libs"

CDEPEND="
	dev-libs/boost
	dev-libs/libedit
	dev-libs/crypto++
	sys-apps/keyutils
	fuse? ( sys-fs/fuse )
	libatomic? ( dev-libs/libatomic_ops )
	gtk? (
			x11-libs/gtk+:2
			dev-cpp/gtkmm:2.4
		)
	radosgw? (
				dev-libs/fcgi
				dev-libs/expat
			)
	"
DEPEND="${CDEPEND}
	dev-util/pkgconfig"
RDEPEND="${CDEPEND}
	sys-fs/btrfs-progs"

STRIP_MASK="/usr/lib*/rados-classes/*"

src_prepare() {
	sed -e 's:invoke-rc\.d.*:/etc/init.d/ceph reload >/dev/null:' \
		-i src/logrotate.conf || die
	sed -i "/^docdir =/d" src/Makefile.am || die #fix doc path
	# disable testsnaps
	sed -e '/testsnaps/d' -i src/Makefile.am || die
	epatch "${FILESDIR}/${PN}-0.26-autotools.patch"
	eautoreconf
}

src_configure() {
	econf \
		--without-hadoop \
		--without-tcmalloc \
		--docdir=/usr/share/doc/${PF} \
		--includedir=/usr/include \
		$(use_with debug) \
		$(use_with fuse) \
		$(use_with libatomic libatomic-ops) \
		$(use_with radosgw) \
		$(use_with gtk gtk2) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	find "${D}" -type f -name "*.la" -exec rm -f {} \;

	rmdir "${D}/usr/sbin"

	exeinto /usr/$(get_libdir)/ceph || die
	newexe src/init-ceph ceph_init.sh || die

	insinto /etc/logrotate.d/ || die
	newins src/logrotate.conf ${PN} || die

	chmod 644 "${D}"/usr/share/doc/${PF}/sample.* || die

	keepdir /var/lib/${PN} || die
	keepdir /var/lib/${PN}/tmp || die
	keepdir /var/log/${PN}/stat || die
	keepdir /var/run/${PN} || die

	newinitd "${FILESDIR}/${PN}.initd" ${PN} || die
	newconfd "${FILESDIR}/${PN}.confd" ${PN} || die
}
