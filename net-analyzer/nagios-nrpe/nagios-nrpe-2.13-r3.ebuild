# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-nrpe/nagios-nrpe-2.13-r3.ebuild,v 1.1 2012/08/23 23:03:15 flameeyes Exp $

EAPI=4

inherit eutils toolchain-funcs multilib user autotools

DESCRIPTION="Nagios Remote Plugin Executor"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/nrpe-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE="command-args ssl tcpd"

DEPEND=">=net-analyzer/nagios-plugins-1.3.0
	ssl? ( dev-libs/openssl )
	tcpd? ( sys-apps/tcp-wrappers )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/nrpe-${PV}"

pkg_setup() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /dev/null nagios

	elog "If you plan to use \"nrpe_check_control\" then you may want to specify"
	elog "different command and services files. You can override the defaults"
	elog "through the \"NAGIOS_COMMAND_FILE\" and \"NAGIOS_SERVICES_FILE\" environment variables."
	elog "NAGIOS_COMMAND_FILE=${NAGIOS_COMMAND_FILE:-/var/rw/nagios.cmd}"
	elog "NAGIOS_SERVICES_FILE=${NAGIOS_SERVICES_FILE:-/etc/services.cfg}"
}

src_prepare() {
	# Add support for large output,
	# http://opsview-blog.opsera.com/dotorg/2008/08/enhancing-nrpe.html
	epatch "${FILESDIR}/nagios-nrpe-2.13-multiline.patch"

	# TCP wrappers conditional, bug 326367
	epatch "${FILESDIR}/nagios-nrpe-2.13-tcpd.patch"
	# Make command-args really conditional, bug 397603
	epatch "${FILESDIR}/nagios-nrpe-2.13-command-args.patch"

	sed -i -e '/define \(COMMAND\|SERVICES\)_FILE/d' contrib/nrpe_check_control.c || die

	sed -i -e \
		"s#pid_file=/var/run/nrpe.pid#pid_file=/var/run/nrpe/nrpe.pid#" \
		sample-config//nrpe.cfg.in || die "sed failed"

	eautoreconf
}

src_configure() {
	econf \
		--libexecdir=/usr/$(get_libdir)/nagios/plugins \
		--localstatedir=/var/nagios \
		--sysconfdir=/etc/nagios \
		--with-nrpe-user=nagios \
		--with-nrpe-group=nagios \
		$(use_enable ssl) \
		$(use_enable tcpd tcp-wrapper) \
		$(use_enable command-args)
}

src_compile() {
	emake all

	# Add nifty nrpe check tool
	$(tc-getCC) ${CPPFLAGS} ${CFLAGS} \
		-DCOMMAND_FILE=\"${NAGIOS_COMMAND_FILE:-/var/rw/nagios.cmd}\" \
		-DSERVICES_FILE=\"${NAGIOS_SERVICES_FILE:-/etc/services.cfg}\" \
		${LDFLAGS} -o nrpe_check_control contrib/nrpe_check_control.c || die
}

src_install() {
	insinto /etc/nagios
	newins sample-config/nrpe.cfg nrpe.cfg
	fowners root:nagios /etc/nagios/nrpe.cfg
	fperms 0640 /etc/nagios/nrpe.cfg

	exeinto /usr/libexec
	doexe src/nrpe

	newinitd "${FILESDIR}"/nrpe.init nrpe

	dodoc LEGAL Changelog README SECURITY \
		contrib/README.nrpe_check_control \
		$(usex ssl README.SSL)

	insinto /etc/xinetd.d/
	doins "${FILESDIR}/nrpe.xinetd.2"

	exeinto /usr/$(get_libdir)/nagios/plugins
	doexe src/check_nrpe nrpe_check_control
}

pkg_postinst() {
	elog "If you are using the nrpe daemon, remember to edit"
	elog "the config file /etc/nagios/nrpe.cfg"

	if use command-args ; then
		ewarn ""
		ewarn "You have enabled command-args for NRPE. This enables"
		ewarn "the ability for clients to supply arguments to commands"
		ewarn "which should be run. "
		ewarn "THIS IS CONSIDERED A SECURITY RISK!"
		ewarn "Please read /usr/share/doc/${PF}/SECURITY.bz2 for more info"
	fi
}
