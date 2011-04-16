# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/heartbeat/heartbeat-2.0.8.ebuild,v 1.21 2011/04/16 18:59:10 armin76 Exp $

inherit autotools flag-o-matic eutils

DESCRIPTION="Heartbeat high availability cluster manager"
HOMEPAGE="http://www.linux-ha.org"
SRC_URI="http://www.linux-ha.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 -mips -s390 ~x86"
IUSE="ldirectord doc snmp management"

RDEPEND="
	=dev-libs/glib-2*
	net-libs/libnet
	>=dev-lang/perl-5.8.8
	net-misc/iputils
	virtual/ssh
	net-libs/gnutls
	ldirectord? (	sys-cluster/ipvsadm
			dev-perl/Net-DNS
			dev-perl/libwww-perl
			dev-perl/perl-ldap
			virtual/perl-libnet
			dev-perl/Crypt-SSLeay
			dev-perl/HTML-Parser
			dev-perl/perl-ldap
			dev-perl/Mail-IMAPClient
			dev-perl/Mail-POP3Client
			dev-perl/MailTools
	)
	snmp? ( net-analyzer/net-snmp )
	net-misc/telnet-bsd
	dev-lang/swig
	management? (
		>=dev-lang/python-2.4
		>=dev-python/pygtk-2.4
		virtual/pam
	)
	"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	#epatch "${FILESDIR}"/${P}-update-resources-failcount.patch
	epatch "${FILESDIR}"/${P}-crm-leaks.patch \
		"${FILESDIR}"/${P}-delay.patch \
		"${FILESDIR}"/${P}-glibc.patch \
		"${FILESDIR}"/${P}-asneeded.patch \
		"${FILESDIR}"/${P}-install_fix.patch \
		"${FILESDIR}"/${P}-crm-assert.patch

	sed -i \
		-e 's:libgnutls-config:pkg-config gnutls:g' \
		lib/mgmt/Makefile.am \
		lib/plugins/quorumd/Makefile.am \
		lib/plugins/quorum/Makefile.am \
		membership/quorumd/Makefile.am \
		mgmt/client/Makefile.am \
		mgmt/daemon/Makefile.am
	eautoreconf
}

src_compile() {
	./configure --prefix=/usr \
		--mandir=/usr/share/man \
		--sysconfdir=/etc \
		--localstatedir=/var \
		--with-group-name=cluster \
		--with-group-id=65 \
		--with-ccmuser-name=cluster \
		--with-ccmuser-id=65 \
		--enable-checkpointd \
		--enable-crm \
		--enable-lrm \
		--disable-fatal-warnings \
		$(use_enable management mgmt) \
		|| die
	emake -j 1 || die "compile problem"
}

pkg_preinst() {
	# check for cluster group, if it doesn't exist make it
	if ! grep -q cluster.*65 /etc/group ; then
		groupadd -g 65 cluster
	fi
	# check for cluster user, if it doesn't exist make it
	if ! grep -q cluster.*65 /etc/passwd ; then
		useradd -u 65 -g cluster -s /dev/null -d /var/lib/heartbeat cluster
	fi
}

src_install() {
	make DESTDIR="${D}" install || die

	# heartbeat modules need these dirs
	#keepdir /var/lib/heartbeat/ckpt /var/lib/heartbeat/ccm /var/lib/heartbeat

	keepdir /var/lib/heartbeat/crm /var/lib/heartbeat/lrm /var/lib/heartbeat/fencing
	keepdir /var/lib/heartbeat/cores/cluster /var/lib/heartbeat/cores/root /var/lib/heartbeat/cores/nobody

	keepdir /var/run/heartbeat/ccm /var/run/heartbeat/crm

	keepdir /etc/ha.d/conf

	dosym /usr/sbin/ldirectord /etc/ha.d/resource.d/ldirectord || die

	if use management ; then
		keepdir /var/lib/heartbeat/mgmt
	fi

	# if ! USE="ldirectord" then don't install it
	if ! use ldirectord ; then
		rm "${D}"/etc/init.d/ldirectord
		rm "${D}"/etc/logrotate.d/ldirectord
		rm "${D}"/etc/ha.d/resource.d/ldirectord
		rm "${D}"/usr/share/man/man8/supervise-ldirectord-config.8
		rm "${D}"/usr/share/man/man8/ldirectord.8
		rm "${D}"/usr/sbin/ldirectord
		rm "${D}"/usr/sbin/supervise-ldirectord-config
	fi

	dodir /var/lib/heartbeat/cores/cluster
	keepdir /var/lib/heartbeat/cores/cluster
	newinitd "${FILESDIR}"/heartbeat-init heartbeat

	dodoc ldirectord/ldirectord.cf doc/*.cf doc/haresources doc/authkeys || die
	if use doc ; then
		dodoc README doc/*.txt doc/AUTHORS doc/COPYING  || die
	fi
}

pkg_postinst() {
	# Change wrong permissions
	chown -R cluster:cluster /var/run/heartbeat/ccm
	chown -R cluster:cluster /var/run/heartbeat/crm
	chown -R cluster:cluster /var/lib/heartbeat/cores
	chown -R cluster:cluster /var/lib/heartbeat/crm
	chown -R cluster:cluster /var/lib/heartbeat/pengine
	chown -R cluster:cluster /var/lib/heartbeat/cores/cluster
}
