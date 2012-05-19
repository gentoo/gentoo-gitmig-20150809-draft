# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd/jabberd-1.6.1.1-r1.ebuild,v 1.22 2012/05/19 14:50:11 ssuominen Exp $

EAPI=4
WANT_AUTOMAKE=1.9
inherit autotools eutils

DESCRIPTION="Open-source Jabber server"
HOMEPAGE="http://www.jabber.org/ http://jabberd.org/"
SRC_URI="http://download.jabberd.org/jabberd14/jabberd14-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc sparc x86 ~x86-fbsd"
IUSE="ipv6 mysql postgres"

RDEPEND="dev-libs/expat
	dev-libs/libgcrypt
	dev-libs/popt
	>=dev-libs/pth-1.4.0
	net-dns/libidn
	>=net-im/jabber-base-0.01
	net-libs/gnutls
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-server )"
DEPEND="${RDEPEND}
	!net-im/jabberd2
	virtual/pkgconfig"

DOCS="mysql.sql pgsql_createdb.sql README* UPGRADE"

S=${WORKDIR}/jabberd14-${PV}

pkg_setup() {
	if use ipv6; then
		ewarn "Without full ipv6 support, jabberd will show the error:"
		ewarn '   "mio unable to listen"'
		ewarn "To fix this, emerge jabberd without the ipv6 USE flag."
	fi
}

src_prepare() {
	epatch \
		"${FILESDIR}"/${P}-glibc-2.10.patch \
		"${FILESDIR}"/${P}-gnutls2.2.patch \
		"${FILESDIR}"/${P}-sandbox.patch \
		"${FILESDIR}"/${P}-parallel-make.patch \
		"${FILESDIR}"/${P}-undefineddebug.patch \
		"${FILESDIR}"/${P}-libtool2.2.patch \
		"${FILESDIR}"/${P}-underlinking.patch

	eautoreconf
}

src_configure() {
	unset LC_ALL LC_CTYPE

	econf \
		--sysconfdir=/etc/jabber \
		--enable-ssl \
		$(use ipv6 && echo --enable-ipv6) \
		$(use_with mysql) \
		$(use_with postgres postgresql)
}

src_install() {
	default

	newinitd "${FILESDIR}"/${P}.init jabber

	# net-im/jabber-base provides needed directories
	rm -rf "${ED}"/var
	mv "${ED}"/etc/jabber/jabber.xml "${ED}"/etc/jabber/jabberd.xml
	mv "${ED}"/etc/jabber/jabber.xml.dist "${ED}"/etc/jabber/jabberd.xml.dist

	sed -i \
		-e 's,/var/lib/spool/jabberd,/var/spool/jabber,g' \
		-e 's,/var/lib/log/jabberd,/var/log/jabber,g' \
		-e 's,/var/lib/run/jabberd,/var/run/jabber,g' \
		-e 's,jabber.pid,jabberd14.pid,g' \
		"${ED}"/etc/jabber/jabberd.xml{,.dist} || die
}

pkg_postinst() {
	echo
	elog 'The various IM transports for jabber are now separate packages,'
	elog 'which you will need to install separately if you want them:'
	elog '   net-im/pymsn-t - MSN transport'
	elog '   net-im/jud - Jabber User Directory'
	elog '   net-im/yahoo-transport - Yahoo IM system'
	elog '   net-im/mu-conference - Jabber multi user conference'
	echo
	ewarn 'If upgrading from an older version, please stop jabberd BEFORE'
	ewarn 'updating the init.d script, or you will end with a "dead" server.'
	ewarn
	ewarn 'The configuration filename has changed:'
	ewarn '   Configure your server in /etc/jabber/jabberd.xml'
	ewarn
	ewarn 'If you are upgrading from jabberd-1.4, please read UPGRADE.'
	ewarn 'Please note that filespool(individual xml files per account)'
	ewarn 'is deprecated. Migrate to one of the database storage backends,'
	ewarn 'and read UPGRADE for instructions.'
	ewarn 'If you wish to continue to use the filespool backend, read'
	ewarn 'README.filespool.'
	echo
}
