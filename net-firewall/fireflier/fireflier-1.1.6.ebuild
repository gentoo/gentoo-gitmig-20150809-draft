# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-firewall/fireflier/fireflier-1.1.6.ebuild,v 1.1 2007/02/15 23:42:38 jokey Exp $

inherit eutils kde linux-mod qt3

MY_P=${P/-/_}
DESCRIPTION="FireFlier, a personnal firewall for Liux based on IPTables"
HOMEPAGE="http://fireflier.sf.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tgz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE="ssl qt3"

DEPEND="net-firewall/iptables
	sys-libs/pam
	dev-libs/openssl
	qt3? ( $(qt_min_version 3.3) )"

# Checking if modules a present
modules_check() {
	ebegin "Checking of kernel has the needed modules"
	linux_chkconfig_present NETFILTER
	linux_chkconfig_present IP_NF_QUEUE
	linux_chkconfig_present IP_NF_IPTABLES
	linux_chkconfig_present IP_NF_MATCH_STATE
	linux_chkconfig_present IP_NF_FILTER
	eend $?

	if [ "$?" != 0 ]
	then
		eerror "This program need following modules:"
		eerror "CONFIG_NETFILTER CONFIG_IP_NF_QUEUE CONFIG_IP_NF_IPTABLES"
		eerror "CONFIG_IP_NF_MATCH_STATE CONFIG_IP_NF_FILTER"
		eerror
		eerror "Please compile these modules into your kernel"
		die "Modules needed"
	fi
}

src_compile() {
	# Compile the server
	# Check for modules
	mkdir -p $T/fakehome
	mkdir -p $T/fakehome/.qt
	export HOME="$T/fakehome"
	addwrite "${QTDIR}/etc/settings"

	modules_check
	einfo "Compiling the Fireflier Server..."
	cd "${S}"/server
	econf || die "Failed to configure FireFlier server"
	emake || die "Failed to compile FireFlier server"
	# Compile the QT client
	if use qt3 ; then
		einfo "Compiling the Fireflier QT client"
		cd "${S}"/qtclient
		[ -f configure ] || (aclocal && autoconf)
		econf --with-x \
			--with-Qt-dir=${QTDIR} || die "Failed to configure QT client"
		emake || die "Failed to compile QT client"
	fi
}

src_install () {
	cd "${S}"/server
	make DESTDIR="${D}" install || die "Failed to install server"
	newinitd "${FILESDIR}"/fireflier.initd fireflier
	doman man/fireflier.1

	dodir /usr/bin
	if use qt3 ; then
		cd "${S}"/qtclient
		make DESTDIR="${D}" install || die "Failed to install QT client"
	fi
	cd "${S}"
	dodoc AUTHORS AUTOLOGIN README TODO protocol.lyx
}

pkg_postinst () {
	ewarn "If you are using NIS or other networked naming solutions"
	ewarn "then you need to make sure they are allowed by iptables"
	ewarn "the first time you start fireflierd as otherwise your"
	ewarn "system will be nearly unusable (no username-resolution!)"
}

