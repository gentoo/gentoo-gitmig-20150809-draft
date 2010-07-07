# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/pacemaker/pacemaker-1.0.8.ebuild,v 1.2 2010/07/07 11:53:55 xarthisius Exp $

EAPI="2"

MY_PN="Pacemaker"
MY_P="${MY_PN}-${PV}"
PYTHON_DEPEND="2"
inherit python autotools multilib eutils base flag-o-matic

DESCRIPTION="Pacemaker CRM"
HOMEPAGE="http://www.clusterlabs.org/"
SRC_URI="http://hg.clusterlabs.org/${PN}/stable-1.0/archive/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+ais heartbeat snmp static-libs"

RDEPEND="
	dev-libs/libxslt
	sys-cluster/cluster-glue
	sys-cluster/resource-agents
	ais? ( sys-cluster/openais )
	heartbeat? ( >=sys-cluster/heartbeat-3.0.0 )
	snmp? ( net-analyzer/net-snmp )
	!heartbeat? ( !ais? ( sys-cluster/openais ) )
"
DEPEND="${RDEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-asneeded.patch"
	"${FILESDIR}/${P}-installpaths.patch"
)

S="${WORKDIR}/${MY_PN}-1-0-${MY_P}"

pkg_setup() {
	if ! use ais && ! use heartbeat; then
		ewarn "You disabled both cluster implementations"
		ewarn "Silently enabling OpenAIS/CoroSync support."
	fi

	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	base_src_prepare
	sed -i -e "/ggdb3/d" configure.ac || die
	eautoreconf
}

src_configure() {
	local myopts=""

	use hearbeat || use ais || myopts="--with-ais"
	# appends lib to localstatedir automatically
	econf \
		--localstatedir=/var \
		--disable-dependency-tracking \
		--disable-fatal-warnings \
		--without-esnmp \
		$(use_with ais) \
		$(use_with heartbeat) \
		$(use_with snmp) \
		$(use_enable static-libs static) \
		${myopts}
}
