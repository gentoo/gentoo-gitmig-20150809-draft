# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/cluster-glue/cluster-glue-1.0.6.ebuild,v 1.1 2010/08/02 05:46:20 xarthisius Exp $

EAPI="2"

MY_P="${P/cluster-}"
inherit autotools multilib eutils base

DESCRIPTION="Library pack for Heartbeat / Pacemaker"
HOMEPAGE="http://www.linux-ha.org/wiki/Cluster_Glue"
SRC_URI="http://hg.linux-ha.org/glue/archive/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="doc static-libs"

RDEPEND="app-arch/bzip2
	dev-libs/glib:2
	net-libs/libnet:1.1
	net-misc/curl
	net-misc/iputils
	|| ( net-misc/netkit-telnetd net-misc/telnet-bsd )
	dev-libs/libxml2
	!<sys-cluster/heartbeat-3.0"
DEPEND="${RDEPEND}
	doc? (
		dev-libs/libxslt
		app-text/docbook-xsl-stylesheets
		)"

S="${WORKDIR}/Reusable-Cluster-Components-${MY_P}"

PATCHES=(
	"${FILESDIR}/1.0.5-docs.patch"
	"${FILESDIR}/1.0.5-respect_cflags.patch"
)

src_prepare() {
	base_src_prepare
	eautoreconf
}

src_configure() {
	local myopts

	use doc && myopts=" --enable-doc"
	econf \
		$(use_enable static-libs static) \
		--disable-fatal-warnings \
		--disable-dependency-tracking \
		--docdir=/usr/share/doc/${PF} \
		--enable-libnet \
		--localstatedir=/var \
		--with-ocf-root=/usr/$(get_libdir)/ocf \
		--sysconfdir=/var \
		${myopts} \
		--with-group-id=65 --with-ccmuser-id=65 \
		--with-daemon-user=hacluster --with-daemon-group=haclient
}

src_install() {
	base_src_install

	dodir /var/lib/heartbeat/cores
	dodir /var/lib/heartbeat/lrm

	keepdir /var/lib/heartbeat/cores
	keepdir /var/lib/heartbeat/lrm

	# init.d file
	cp "${FILESDIR}"/heartbeat-logd.init "${T}/" || die
	sed -i \
		-e "s:%libdir%:$(get_libdir):" \
		"${T}/heartbeat-logd.init" || die
	newinitd "${T}/heartbeat-logd.init" heartbeat-logd || die
	rm "${D}"/etc/init.d/logd
}

pkg_preinst() {
	# check for cluster group, if it doesn't exist make it
	groupadd -g 65 haclient
	# check for cluster user, if it doesn't exist make it
	useradd -u 65 -g haclient -s /dev/null -d /var/lib/heartbeat hacluster
}

pkg_postinst() {
	chown -R hacluster:haclient /var/lib/heartbeat/cores
	chown -R hacluster:haclient /var/lib/heartbeat/lrm
}
