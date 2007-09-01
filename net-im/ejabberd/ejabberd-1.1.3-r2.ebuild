# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ejabberd/ejabberd-1.1.3-r2.ebuild,v 1.3 2007/09/01 07:04:02 opfer Exp $

inherit eutils multilib versionator

JABBER_ETC="/etc/jabber"
JABBER_RUN="/var/run/jabber"
JABBER_SPOOL="/var/spool/jabber"
JABBER_LOG="/var/log/jabber"

DESCRIPTION="The Erlang Jabber Daemon"
HOMEPAGE="http://ejabberd.jabber.ru/"
SRC_URI="http://process-one.net/en/projects/${PN}/download/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug mod_irc mod_muc mod_pubsub ldap odbc ssl web"

DEPEND=">=net-im/jabber-base-0.01
	>=dev-libs/expat-1.95
	>=dev-lang/erlang-10.2.0
	odbc? ( dev-db/unixODBC )
	ldap? ( =net-nds/openldap-2* )
	ssl? ( >=dev-libs/openssl-0.9.8e )"

PROVIDE="virtual/jabber-server"
S=${WORKDIR}/${P}/src

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Bug #171427
	epatch "${FILESDIR}/${PV}-missing-declaration.patch"
}

src_compile() {
	econf ${myconf}							\
		$(use_enable mod_irc)					\
		$(use_enable ldap eldap)				\
		$(use_enable mod_muc)					\
		$(use_enable mod_pubsub)				\
		$(use_enable ssl tls)					\
		$(use_enable web)					\
		$(use_enable odbc)					\
		|| die "econf failed"

	if useq debug; then
		emake ejabberd_debug=true || die "compiling ejabberd core failed"
	else
		emake || die "compiling ejabberd core failed"
	fi
}

src_install() {
	make								\
		DESTDIR="${D}"						\
		EJABBERDDIR="${D}/usr/$(get_libdir)/erlang/lib/${P}"	\
		ETCDIR="${D}${JABBER_ETC}"				\
		LOGDIR="${D}${JABBER_LOG}"				\
		install							\
		|| die "install failed"

	chown -R jabber:jabber "${D}${JABBER_ETC}"
	chown -R jabber:jabber "${D}${JABBER_LOG}"
	chown -R jabber:jabber "${D}/usr/$(get_libdir)/erlang/lib/${P}"

	insinto /usr/share/doc/${PF}
	dohtml doc/*.{html,png}

	#
	# Create /usr/bin/ejabberd
	#
	cat <<EOF > "${T}/ejabberd"
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
	cat <<EOF > "${T}/ejabberdctl"
#!/bin/sh

exec env HOME=${JABBER_RUN} \\
	erl -pa /usr/$(get_libdir)/erlang/lib/${P}/ebin \\
		${pa} \\
		-noinput \\
		-sname ejabberdctl \\
		-s ejabberd_ctl \\
		-extra \$@
EOF

	dobin "${T}/ejabberdctl"
	dobin "${T}/ejabberd"

	newinitd "${FILESDIR}/ejabberd-1.1.1-r1.initd" ${PN}
	newconfd "${FILESDIR}/${P}.confd" ${PN}

	insinto ${JABBER_ETC}
	doins "${FILESDIR}/inetrc"
	if useq ssl ; then
		doins "${FILESDIR}/ssl.cnf"
		newins "${FILESDIR}/self-cert-v2.sh" self-cert.sh
	fi
}

pkg_postinst() {
	elog "For configuration instructions, please see /usr/share/doc/${PF}/html/guide.html"
	elog "or the online version at http://www.process-one.net/en/projects/ejabberd/docs/guide_en.html"
	echo
	if useq ssl ; then
		if [ ! -e /etc/jabber/ssl.pem ]; then
			elog "Please edit ${JABBER_ETC}/ssl.cnf and run ${JABBER_ETC}/self-cert.sh"
			elog "Ejabberd may refuse to start without an SSL certificate"
		fi
	fi
	if ! useq web ; then
		elog "The web USE flag is off, this has disabled the web admin interface."
	fi
	if useq odbc ; then
		elog "Please add a column askmessage to the rosterusers table if migrating from 1.1.1"
	fi
}
