# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/openvswitch/openvswitch-1.6.1.ebuild,v 1.1 2012/06/27 08:49:35 dev-zero Exp $

EAPI=4

PYTHON_DEPEND="monitor? 2"

inherit eutils linux-info python

DESCRIPTION="Production quality, multilayer virtual switch."
HOMEPAGE="http://openvswitch.org"
SRC_URI="http://openvswitch.org/releases/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug monitor +pyside +ssl"

RDEPEND="ssl? ( dev-libs/openssl )
	monitor? ( dev-python/twisted
		dev-python/twisted-conch
		pyside? ( dev-python/pyside )
		!pyside? ( dev-python/PyQt4 )
		net-zope/zope-interface )
	debug? ( dev-lang/perl )"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

CONFIG_CHECK="~NET_CLS_ACT ~NET_CLS_U32 ~NET_SCH_INGRESS ~NET_ACT_POLICE ~IPV6 ~TUN ~OPENVSWITCH"

pkg_setup() {
	linux-info_pkg_setup
	python_set_active_version 2
	python_pkg_setup
}

src_configure() {
	set_arch_to_kernel
	use monitor || export ovs_cv_python="no"
	use pyside || export ovs_cv_pyuic4="no"
	local modconf
	econf ${modconf} \
		--with-rundir=/var/run/openvswitch \
		--with-logdir=/var/log/openvswitch \
		--with-pkidir=/etc/openvswitch/pki \
		$(use_enable ssl) \
		$(use_enable !debug ndebug)
}

src_compile() {
	default

	use monitor && python_convert_shebangs 2 \
		utilities/ovs-{pcap,tcpundump,test,vlan-test} \
		utilities/bugtool/ovs-bugtool \
		ovsdb/ovsdbmonitor/ovsdbmonitor
}

src_install() {
	default

	# not working without the brcompat_mod kernel module which did not get
	# included in the kernel and we can't build it anymore
	rm "${D}/usr/sbin/ovs-brcompatd" "${D}/usr/share/man/man8/ovs-brcompatd.8"

	keepdir /var/log/openvswitch
	keepdir /etc/openvswitch/pki

	rm -rf "${D}/var/run"
	use monitor || rmdir "${D}/usr/share/openvswitch/ovsdbmonitor"
	use debug || rm "${D}/usr/bin/ovs-parse-leaks"

	newconfd "${FILESDIR}/ovsdb-server_conf" ovsdb-server
	newconfd "${FILESDIR}/ovs-vswitchd_conf" ovs-vswitchd
	doinitd "${FILESDIR}/ovsdb-server"
	doinitd "${FILESDIR}/ovs-vswitchd"

	insinto /etc/logrotate.d
	newins rhel/etc_logrotate.d_openvswitch openvswitch
}

pkg_postinst() {
	use monitor && python_mod_optimize /usr/share/openvswitch/ovsdbmonitor
	python_mod_optimize /usr/share/openvswitch/python

	elog "Use the following command to create an initial database for ovsdb-server:"
	elog "   emerge --config =${CATEGORY}/${PF}"
	elog "(will create a database in /etc/openvswitch/conf.db)"
}

pkg_postrm() {
	use monitor && python_mod_cleanup /usr/share/openvswitch/ovsdbmonitor
	python_mod_cleanup /usr/share/openvswitch/python
}

pkg_config() {
	local db="${PREFIX}/etc/openvswitch/conf.db"
	if [ -e "${db}" ] ; then
		eerror "Database already exists in ${db}, please remove it first."
		die "${db} already exists"
	fi
	"${PREFIX}/usr/bin/ovsdb-tool" create "${db}" /usr/share/openvswitch/vswitch.ovsschema
}
