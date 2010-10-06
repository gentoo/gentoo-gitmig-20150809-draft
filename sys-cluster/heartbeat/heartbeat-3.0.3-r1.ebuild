# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/heartbeat/heartbeat-3.0.3-r1.ebuild,v 1.1 2010/10/06 07:13:42 xarthisius Exp $

EAPI="2"

PYTHON_DEPEND="2"
inherit python autotools multilib eutils base

DESCRIPTION="Heartbeat high availability cluster manager"
HOMEPAGE="http://www.linux-ha.org/wiki/Heartbeat"
SRC_URI="http://hg.linux-ha.org/${PN}-STABLE_3_0/archive/STABLE-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc snmp static-libs"

RDEPEND="
	sys-cluster/cluster-glue
	dev-libs/glib:2
	virtual/ssh
	net-libs/gnutls
	snmp? ( net-analyzer/net-snmp )
	dev-lang/swig
	"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"
PDEPEND="sys-cluster/resource-agents"

S="${WORKDIR}/Heartbeat-3-0-STABLE-${PV}"

PATCHES=(
	"${FILESDIR}/${PV}-fix_configure.patch"
	"${FILESDIR}/${PV}-docs.patch"
	"${FILESDIR}/${PV}-python_tests.patch"
)

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-fatal-warnings \
		$(use_enable static-libs static) \
		$(use_enable doc) \
		--disable-tipc \
		--enable-libnet \
		--enable-ipmilan \
		--enable-dopd \
		--libdir=/usr/$(get_libdir) \
		--localstatedir=/var \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable snmp)
}

src_install() {
	base_src_install

	cp "${FILESDIR}"/heartbeat-init "${T}/" || die
	sed -i \
		-e "s:%libdir%:$(get_libdir):" \
		"${T}/heartbeat-init" || die
	newinitd "${T}/heartbeat-init" heartbeat || die

	# fix collisions
	rm -rf "${D}"/usr/include/heartbeat/{compress,ha_msg}.h

	if use doc ; then
		dodoc README doc/*.txt doc/AUTHORS  || die
	fi
}
