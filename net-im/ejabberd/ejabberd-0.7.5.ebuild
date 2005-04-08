# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ejabberd/ejabberd-0.7.5.ebuild,v 1.1 2005/04/08 20:02:35 humpback Exp $

inherit eutils

DESCRIPTION="The Erlang Jabber Daemon"
HOMEPAGE="http://ejabberd.jabber.ru/"
#Mirror from jabberstudio is a pain
SRC_URI="http://www.gentoo-pt.org/~humpback/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc"
IUSE="mod_pubsub mod_irc mod_muc ldap web ssl"

DEPEND=">=dev-libs/expat-1.95
		>=dev-lang/erlang-8b
		ssl? ( >=dev-libs/openssl-0.9.6 )"
PROVIDE="virtual/jabber-server"

S=${WORKDIR}/${P}/src

src_compile() {
	local myconf

	use mod_pubsub || myconf="--disable-mod_pubsub"
	use mod_irc || myconf="${myconf} --disable-mod_irc"
	use mod_muc || myconf="${myconf} --disable-mod_muc"
	use ldap || myconf="${myconf} --disable-eldap"
	use web || myconf="${myconf} --disable-web"
	use ssl || myconf="${myconf} --disable-tls"

	econf ${myconf} || die

	emake || die "emake failed"
}

src_install() {
	enewgroup jabber
	enewuser ejabberd -1 /bin/false /var/run/ejabberd jabber

	make DESTDIR=${D} install || die "install failed"

	# This configuration file contains configurations for all modules,
	# including ones that were potentially not built due to USE flags,
	# so we'll have to move it out of the way so it isn't accidentally
	# used.
	mv ${D}/etc/ejabberd/ejabberd.cfg ${D}/etc/ejabberd/ejabberd.cfg.example

	# Database
	dodir /var/spool/ejabberd
	fowners ejabberd:jabber /var/spool/ejabberd

	# Home
	dodir /var/run/ejabberd
	fowners ejabber:jabber /var/run/ejabberd

	# Logs
	dodir /var/log/ejabberd
	fowners ejabber:jabber /var/log/ejabberd

	cd ..
	dodoc doc/*.tex
	dohtml doc/*.html
	dohtml doc/*.png

	dobin ${FILESDIR}/ejabberdctl
	dobin ${FILESDIR}/ejabberd

	exeinto /etc/init.d
	newexe ${FILESDIR}/ejabberd-0.7.5.initd ejabberd

	insinto /etc/conf.d
	newins ${FILESDIR}/ejabberd-0.7.5.confd ejabberd

	# This file is required to make ejabberd use SRV records for
	# server-to-server connections, according to
	# <URL:http://lists.jabber.ru/pipermail/ejabberd/2005-March/000829.html>
	insinto /etc/ejabberd
	doins ${FILESDIR}/inetrc
}

pkg_postinst() {
	if [ ! -e /etc/ejabberd/ejabberd.cfg ]
	then
		einfo "A sample configuration file has been installed in /etc/ejabberd/ejabberd.cfg.example."
		einfo "Please copy it to /etc/ejabberd/ejabberd.cfg and edit it according to your needs."
		einfo "For configuration instructions, please see /usr/share/doc/${P}/html/guide.html"
	fi
}
