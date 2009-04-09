# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/ejabberd/ejabberd-2.0.4-r1.ebuild,v 1.2 2009/04/09 05:40:39 pva Exp $

inherit eutils multilib

JABBER_ETC="/etc/jabber"
JABBER_RUN="/var/run/jabber"
JABBER_SPOOL="/var/spool/jabber"
JABBER_LOG="/var/log/jabber"

MY_PV=${PV}
MY_P=${PN}-${MY_PV}

DESCRIPTION="The Erlang Jabber Daemon"
HOMEPAGE="http://www.ejabberd.im/"
SRC_URI="http://www.process-one.net/downloads/ejabberd/${PV}/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug mod_irc mod_muc mod_pubsub ldap odbc pam ssl web zlib"

DEPEND=">=net-im/jabber-base-0.01
	>=dev-libs/expat-1.95
	>=dev-lang/erlang-11.2.5
	odbc? ( dev-db/unixODBC )
	ldap? ( =net-nds/openldap-2* )
	ssl? ( >=dev-libs/openssl-0.9.8e )
	zlib? ( sys-libs/zlib )"
RDEPEND="${DEPEND}"

PROVIDE="virtual/jabber-server"

S=${WORKDIR}/${MY_P}/src

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Bug #171427
	epatch "${FILESDIR}/2.0.0-missing-declaration.patch"
	epatch "${FILESDIR}/${PN}-2.0.4-fix-EJAB-890.patch" #263950

	# get rid of the prefix
	sed -i -e "s/\\@prefix\\@//" "${S}/Makefile.in" \
		|| die "cannot sed Makefile.in"
	# we want ejabberdctl in /usr/sbin not /sbin !!!
	sed -i -e "s/\\/sbin/\\/usr\\/sbin/" "${S}/Makefile.in" \
		|| die "cannot sed Makefile.in"
}

src_compile() {
		econf --prefix=/ \
		$(use_enable mod_irc) \
		$(use_enable ldap eldap) \
		$(use_enable mod_muc) \
		$(use_enable mod_pubsub) \
		$(use_enable ssl tls) \
		$(use_enable web) \
		$(use_enable odbc) \
		$(use_enable zlib ejabberd_zlib) \
		$(use_enable pam) \
		|| die "econf failed"

	if useq debug; then
		emake ejabberd_debug=true || die "compiling ejabberd core failed"
	else
		emake || die "compiling ejabberd core failed"
	fi
}

src_install() {
	make \
		DESTDIR="${D}" \
		EJABBERDDIR="${D}/usr/$(get_libdir)/erlang/lib/${P}" \
		ETCDIR="${D}${JABBER_ETC}" \
		LOGDIR="${D}${JABBER_LOG}" \
		install || die "install failed"

	# remove the default ejabberdctl as we use our own
	rm "${D}/sbin/ejabberdctl"

	insinto ${JABBER_ETC}

	chown -R jabber:jabber "${D}${JABBER_ETC}"
	chown -R jabber:jabber "${D}${JABBER_LOG}"
	chown -R jabber:jabber "${D}/usr/$(get_libdir)/erlang/lib/${P}"

	if useq ssl ; then
		doins "${FILESDIR}/ssl.cnf"
		newins "${FILESDIR}/self-cert-v2.sh" self-cert.sh
	fi

	# Pam helper module permissions
	# http://www.process-one.net/docs/ejabberd/guide_en.html
	if useq pam; then
		chown root:jabber "${D}"/usr/lib/erlang/lib/${P}/priv/bin/epam
		chmod 4750 "${D}"/usr/lib/erlang/lib/${P}/priv/bin/epam
	fi

	cd "${WORKDIR}/${MY_P}/doc"
	dodoc "release_notes_${MY_PV}.txt"
	dohtml *.{html,png}

	# set up /usr/sbin/ejabberd wrapper
	cat "${FILESDIR}/ejabberd-wrapper-2.template" \
		| sed -e "s/\@libdir\@/$(get_libdir)/g" -e "s/\@version\@/${PV}/g" \
		> "${T}/ejabberd"
	exeinto /usr/sbin
	doexe "${T}/ejabberd"

	# set up /usr/sbin/ejabberdctl wrapper
	cat "${FILESDIR}/ejabberdctl-wrapper-2.template" \
		| sed -e "s/\@libdir\@/$(get_libdir)/g" -e "s/\@version\@/${PV}/g" \
		> "${T}/ejabberdctl"
	doexe "${T}/ejabberdctl"

	dodir /var/lib/ejabberd
	newinitd "${FILESDIR}/${PN}-2.initd" ${PN}
	newconfd "${FILESDIR}/${PN}-2.confd" ${PN}

	# fix up the ssl cert paths in /etc/jabber/ejabberd.cfg to use the cert
	# that would be generated by /etc/jabber/self-cert.sh
	sed -i -e "s/\/path\/to\/ssl.pem/\/etc\/jabber\/ssl.pem/g" \
		"${D}${JABBER_ETC}/ejabberd.cfg" || die "Cannot sed ejabberd.cfg"

	# if mod_irc is not enabled, comment out the mod_irc in the default
	# ejabberd.cfg
	if ! use mod_irc; then
		sed -i -e "s/{mod_irc,/%{mod_irc,/" \
			"${D}${JABBER_ETC}/ejabberd.cfg" || die "Cannot sed ejabberd.cfg"
	fi
}

pkg_postinst() {
	elog "For configuration instructions, please see"
	elog "/usr/share/doc/${PF}/html/guide.html, or the online version at"
	elog "http://www.process-one.net/en/projects/ejabberd/docs/guide_en.html"
	if useq ssl ; then
		if [ ! -e /etc/jabber/ssl.pem ]; then
			elog "Please edit ${JABBER_ETC}/ssl.cnf and run ${JABBER_ETC}/self-cert.sh"
			elog "Ejabberd may refuse to start without an SSL certificate"
		fi
	fi
	if ! useq web ; then
		elog "The web USE flag is off, this has disabled the web admin interface."
	fi
	elog "===================================================================="
	elog 'Quick Start Guide:'
	elog '1) Add output of `hostname -f` to /etc/jabber/ejabberd.cfg line 89'
	elog '   {hosts, ["localhost", "thehost"]}.'
	elog '2) Add an admin user to /etc/jabber/ejabberd.cfg line 324'
	elog '   {acl, admin, {user, "theadmin", "thehost"}}.'
	elog '3) Start the server'
	elog '   # /etc/init.d/ejabberd start'
	elog '4) Register the admin user'
	elog '   # /usr/sbin/ejabberdctl register theadmin thehost thepassword'
	elog '5) Log in with your favourite jabber client or using the web admin'
}
