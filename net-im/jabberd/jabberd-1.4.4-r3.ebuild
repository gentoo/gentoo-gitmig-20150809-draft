# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd/jabberd-1.4.4-r3.ebuild,v 1.1 2006/09/27 22:31:36 nelchael Exp $

inherit eutils

S="${WORKDIR}/jabberd-${PV}"
DESCRIPTION="Open Source Jabber Server"
HOMEPAGE="http://www.jabber.org"
SRC_URI="http://download.jabberd.org/jabberd14/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="ssl ipv6 mysql postgres"

DEPEND=">=net-im/jabber-base-0.01
	>=dev-libs/pth-1.4.0
	dev-libs/expat
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	ssl? ( >=dev-libs/openssl-0.9.6i )
	!=net-im/jabberd-2*"

# Block against jabberd-2* is needed - both packages install the same files - collisions!
# jabberd-2* needs to be back at SLOT="0"

pkg_setup() {

	if use postgres && use mysql; then
		eerror "Please select mysql or postgres"
		die "Please select mysql or postgres"
	fi

	if use ipv6; then
		ewarn "You are about to build with ipv6 support, if your system is not using ipv6"
		ewarn "hit Control-C now and emerge with \"USE=-ipv6\" or add it to /etc/portage/package.use "
	fi

}

src_unpack() {

	unpack "${A}"

	# Resolves bug #147342
	epatch "${FILESDIR}/${P}-openssl-0.9.8.patch"

}

src_compile() {

	unset LC_ALL LC_CTYPE

	econf \
		--sysconfdir=/etc/jabber \
		$(use_enable ssl) \
		$(use_enable ipv6) \
		$(use_with mysql) \
		$(use_with postgres postgresql )\
		|| die "econf failed"

	# Broken parallel build
	emake -j 1 || die

}

src_install() {

	make DESTDIR=${D} install || die "make install failed"

	newinitd ${FILESDIR}/${P}.init jabber

	# net-im/jabber-base provides needed directories
	rm -rf "${D}/var"
	mv "${D}/etc/jabber/jabber.xml" "${D}/etc/jabber/jabberd.xml"
	mv "${D}/etc/jabber/jabber.xml.dist" "${D}/etc/jabber/jabberd.xml.dist"
	sed -i \
		-e 's,/var/lib/spool/jabberd,/var/spool/jabber,g' \
		-e 's,/var/lib/log/jabberd,/var/log/jabber,g' \
		-e 's,/var/lib/run/jabberd,/var/run/jabber,g' \
		-e 's,jabber.pid,jabberd14.pid,g' \
		"${D}/etc/jabber/jabberd.xml" \
		"${D}/etc/jabber/jabberd.xml.dist"

}

pkg_postinst() {

	einfo "The various IM transports for jabber are now separate packages,"
	einfo "which you will need to install separately if you want them:"
	einfo "net-im/jit - ICQ transport"
	einfo "net-im/pymsn-t - MSN transport"
	einfo "net-im/jud - Jabber User Directory"
	einfo "net-im/yahoo-transport - Yahoo IM system"
	einfo "net-im/mu-conference - Jabber multi user conference"
	einfo
	ewarn "If upgrading from older version please stop jabberd BEFORE updating the init.d"
	ewarn "script, or you will end with a \"dead\" server."
	ewarn
	ewarn "Configuration file name has changed:"
	ewarn "    configure your server in /etc/jabber/jabberd.xml!"
	ebeep

}
