# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ejabberd/ejabberd-1.1.1.ebuild,v 1.1 2006/06/19 14:07:20 chainsaw Exp $

inherit eutils multilib ssl-cert versionator

JABBER_ETC="/etc/jabber"
JABBER_RUN="/var/run/jabber"
JABBER_SPOOL="/var/spool/jabber"
JABBER_LOG="/var/log/jabber"

DESCRIPTION="The Erlang Jabber Daemon"
HOMEPAGE="http://ejabberd.jabber.ru/"
SRC_URI="http://process-one.net/en/projects/${PN}/download/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mod_irc mod_muc mod_pubsub ldap odbc web"

DEPEND=">=net-im/jabber-base-0.01
	>=dev-libs/expat-1.95
	>=dev-lang/erlang-10.2.0
	odbc? ( dev-db/unixODBC )
	ldap? ( =net-nds/openldap-2* )"

PROVIDE="virtual/jabber-server"
S=${WORKDIR}/${P}/src

src_compile() {
	econf ${myconf}                              \
		$(use_enable mod_irc)                \
		$(use_enable ldap eldap)             \
		$(use_enable mod_muc)                \
		$(use_enable mod_pubsub)             \
		$(use_enable ssl tls)                \
		$(use_enable web)                    \
		$(use_enable odbc)                   \
		|| die "econf failed"

	emake || die "compiling ejabberd core failed"
}

src_install() {
	make                                                       \
		DESTDIR=${D}                                       \
		EJABBERDDIR=${D}/usr/$(get_libdir)/erlang/lib/${P} \
		ETCDIR=${D}${JABBER_ETC}                           \
		LOGDIR=${D}${JABBER_LOG}                           \
	    install \
	    || die "install failed"

	insinto /usr/share/doc/${PF}
	cd ${S}/..
	dodoc doc/release_notes_${PV}.txt
	dohtml doc/*.{html,png}

	#
	# Create /usr/bin/ejabberd
	#
	cat <<EOF > ${T}/ejabberd
#!/bin/bash

erl -pa /usr/$(get_libdir)/erlang/lib/${P}/ebin \\
	${pa} \\
	-sname ejabberd \\
	-s ejabberd \\
	-ejabberd config \"${JABBER_ETC}/ejabberd.cfg\" \\
	log_path \"${JABBER_LOG}/ejabberd.log\" \\
	-kernel inetrc \"${JABBER_ETC}/inetrc\" \\
	-sasl sasl_error_logger \{file,\"${JABBER_LOG}/sasl.log\"\} \\
	-mnesia dir \"${JABBER_SPOOL}\" \\
	\$@
EOF

	#
	# Create /usr/bin/ejabberdctl
	#
	cat <<EOF > ${T}/ejabberdctl
#!/bin/sh

exec env HOME=${JABBER_RUN} \\
	erl -pa /usr/$(get_libdir)/erlang/lib/${P}/ebin \\
		${pa} \\
		-noinput \\
		-sname ejabberdctl \\
		-s ejabberd_ctl \\
		-extra \$@
EOF

	dobin ${T}/ejabberdctl
	dobin ${T}/ejabberd

	newinitd ${FILESDIR}/${P}.initd ${PN}
	newconfd ${FILESDIR}/${P}.confd ${PN}

	insinto ${JABBER_ETC}
	if use ssl; then
		docert ssl
		rm -f ${D}${JABBER_ETC}/ssl.{crt,csr,key}
		fowners jabber:jabber ${JABBER_ETC}/ssl.pem
	fi
	doins ${FILESDIR}/inetrc
}

pkg_postinst() {
	if [ ! -e ${JABBER_ETC}/ejabberd.cfg ]
	then
		einfo "Configuration file has been installed in ${JABBER_ETC}/ejabberd.cfg."
		einfo "Edit it according to your needs. For configuration instructions,"
		einfo "please see /usr/share/doc/${PF}/html/guide.html"
	fi
	if use ssl ; then
		einfo "A script to generate a ssl key has been installed in"
		einfo "${JABBER_ETC}/self-cert.sh . Use it and change the config file to"
		einfo "point to the full path"
	fi
	if ! use web ; then
		einfo "The web USE flag is off, this will disable the web admin interface,"
		einfo "if this was not the intention then add web to your USE flags."
	fi
}
