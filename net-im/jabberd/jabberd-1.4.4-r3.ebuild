# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/jabberd/jabberd-1.4.4-r3.ebuild,v 1.8 2006/10/18 04:37:50 tsunam Exp $

inherit eutils

DESCRIPTION="Open-source Jabber server"
HOMEPAGE="http://www.jabber.org"
SRC_URI="http://download.jabberd.org/jabberd14/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc x86"
IUSE="debug ipv6 mysql postgres ssl"

DEPEND=">=net-im/jabber-base-0.01
	>=dev-libs/pth-1.4.0
	dev-libs/expat
	mysql? ( dev-db/mysql )
	postgres? ( dev-db/postgresql )
	ssl? ( >=dev-libs/openssl-0.9.6i )"

pkg_setup() {

	if use ipv6; then
		ewarn "Without full ipv6 support, jabberd will show the error:"
		ewarn '   "mio unable to listen"'
		ewarn "To fix this, emerge jabberd without the ipv6 USE flag."
	fi

}

src_unpack() {

	unpack "${A}"

	cd "${S}"

	# Resolves bug #147342
	epatch "${FILESDIR}/${P}-openssl-0.9.8.patch"

	# Various fixes from upstream:
	epatch "${FILESDIR}/${P}-str.c-rev1103.patch"
	epatch "${FILESDIR}/${P}-xdb_file.c-rev1107.patch"
	epatch "${FILESDIR}/${P}-xdb_sql.c-rev1211.patch"
	epatch "${FILESDIR}/${P}-genhash.c-rev1253.patch"
	epatch "${FILESDIR}/${P}-crypt.patch"

}

src_compile() {

	unset LC_ALL LC_CTYPE

	# Broken configure script - can't use "use_enable"
	local myconf=
	use debug && myconf="${myconf} --enable-debug --enable-pool-debug"
	use ipv6  && myconf="${myconf} --enable-ipv6"
	use ssl   && myconf="${myconf} --enable-ssl"

	econf \
		--sysconfdir=/etc/jabber \
		${myconf} \
		$(use_with mysql) \
		$(use_with postgres postgresql) \
		|| die "econf failed"

	# Broken parallel build
	emake -j1 || die "emake failed"

}

src_install() {

	make DESTDIR="${D}" install || die "make install failed"

	newinitd "${FILESDIR}"/${P}.init jabber || die "newinitd failed"

	# net-im/jabber-base provides needed directories
	rm -rf "${D}/var"
	mv "${D}/etc/jabber/jabber.xml" "${D}/etc/jabber/jabberd.xml"
	mv "${D}/etc/jabber/jabber.xml.dist" "${D}/etc/jabber/jabberd.xml.dist"

	sed -i \
		-e 's,/var/lib/spool/jabberd,/var/spool/jabber,g' \
		-e 's,/var/lib/log/jabberd,/var/log/jabber,g' \
		-e 's,/var/lib/run/jabberd,/var/run/jabber,g' \
		-e 's,jabber.pid,jabberd14.pid,g' \
		"${D}"/etc/jabber/jabberd.xml{,.dist} \
		|| die "sed failed"

}

pkg_postinst() {

	echo
	einfo 'The various IM transports for jabber are now separate packages,'
	einfo 'which you will need to install separately if you want them:'
	einfo '   net-im/jit - ICQ transport'
	einfo '   net-im/pymsn-t - MSN transport'
	einfo '   net-im/jud - Jabber User Directory'
	einfo '   net-im/yahoo-transport - Yahoo IM system'
	einfo '   net-im/mu-conference - Jabber multi user conference'
	echo
	ewarn 'If upgrading from an older version, please stop jabberd BEFORE'
	ewarn 'updating the init.d script, or you will end with a "dead" server.'
	echo
	ewarn 'The configuration filename has changed:'
	ewarn '   Configure your server in /etc/jabber/jabberd.xml'
	echo
	ebeep

}
