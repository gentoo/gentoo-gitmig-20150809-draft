# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ejabberd/ejabberd-1.1.2-r1.ebuild,v 1.2 2007/03/11 14:25:28 welp Exp $

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
IUSE="mod_irc mod_muc mod_pubsub ldap odbc ssl web"

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

	chown -R jabber:jabber "${D}${JABBER_ETC}"
	chown -R jabber:jabber "${D}${JABBER_LOG}"
	chown -R jabber:jabber "${D}/usr/$(get_libdir)/erlang/lib/${P}"

	insinto /usr/share/doc/${PF}
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

	newinitd ${FILESDIR}/ejabberd-1.1.1-r1.initd ${PN}
	newconfd ${FILESDIR}/ejabberd-1.1.1.confd ${PN}

	insinto ${JABBER_ETC}
	doins ${FILESDIR}/inetrc
	doins ${FILESDIR}/ssl.cnf
	newins ${FILESDIR}/self-cert-v2.sh self-cert.sh
}

pkg_postinst() {
	einfo "For configuration instructions, please see /usr/share/doc/${PF}/html/guide.html"
	einfo "or the online version at http://www.process-one.net/en/projects/ejabberd/docs/guide_en.html"
	echo
	if useq ssl ; then
		if [ ! -e /etc/jabber/ssl.pem ]; then
			ebegin "Creating SSL key"
			sh ${JABBER_ETC}/self-cert.sh &> /dev/null
			eend $?
		fi
		chown jabber:jabber ${JABBER_ETC}/ssl.pem
		ewarn "Please be sure that your ${JABBER_ETC}/ejabber.cfg points to ${JABBER_ETC}/ssl.pem"
		ewarn "You may want to edit ${JABBER_ETC}/ssl.cnf and run ${JABBER_ETC}/self-cert.sh again"
	fi
	if ! useq web ; then
		einfo "The web USE flag is off, this has disabled the web admin interface."
	fi
	if useq odbc ; then
		ewarn "Please add a column askmessage to the rosterusers table if migrating from 1.1.1"
	fi
}
