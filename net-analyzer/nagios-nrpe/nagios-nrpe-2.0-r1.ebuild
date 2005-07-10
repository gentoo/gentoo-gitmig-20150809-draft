# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nagios-nrpe/nagios-nrpe-2.0-r1.ebuild,v 1.1 2005/07/10 04:41:17 ramereth Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Nagios $PV NRPE - Nagios Remote Plugin Executor"
HOMEPAGE="http://www.nagios.org/"
SRC_URI="mirror://sourceforge/nagios/nrpe-${PV}.tar.gz"

RESTRICT="nomirror"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE="ssl command-args"
DEPEND=">=net-analyzer/nagios-plugins-1.3.0
	ssl? ( dev-libs/openssl )"
S="${WORKDIR}/nrpe-${PV}"

pkg_setup() {
	enewgroup nagios
	enewuser nagios -1 /bin/bash /dev/null nagios
}

src_compile() {
	local myconf

	myconf="${myconf} `use_enable ssl` \
					  `use_enable command-args`"

	# Generate the dh.h header file for better security (2005 Mar 20 eldad)
	if useq ssl ; then
		openssl dhparam -C 512 | sed -n '1,/BEGIN DH PARAMETERS/p' | grep -v "BEGIN DH PARAMETERS" > ${S}/src/dh.h
	fi

	./configure ${myconf} \
		--host=${CHOST} \
		--prefix=/usr/nagios \
		--localstatedir=/var/nagios \
		--sysconfdir=/etc/nagios \
		--with-nrpe-user=nagios \
		--with-nrpe-grp=nagios \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake all || die
	# Add nifty nrpe check tool
	cd contrib
	$(tc-getCC) ${CFLAGS} -o nrpe_check_control	nrpe_check_control.c
}

src_install() {
	dodoc LEGAL Changelog README SECURITY README.SSL \
		contrib/README.nrpe_check_control

	insinto /etc/nagios
	newins ${FILESDIR}/nrpe-${PV}.cfg nrpe.cfg
	fowners root:nagios /etc/nagios/nrpe.cfg
	fperms 0640 /etc/nagios/nrpe.cfg

	exeinto /usr/nagios/bin
	doexe src/nrpe

	exeinto /usr/nagios/libexec
	doexe src/check_nrpe contrib/nrpe_check_control

	fowners nagios:nagios /usr/nagios/libexec/check_nrpe /usr/nagios/bin/nrpe
	fperms 0750	/usr/nagios/libexec/check_nrpe /usr/nagios/bin/nrpe

	exeinto /etc/init.d
	newexe ${FILESDIR}/nrpe-${PV} nrpe
}
pkg_postinst() {
	einfo
	einfo "If you are using the nrpe daemon, remember to edit"
	einfo "the config file /etc/nagios/nrpe.cfg"
	einfo

	if useq command-args ; then
		ewarn "You have enabled command-args for NRPE. This enables"
		ewarn "the ability for clients to supply arguments to commands"
		ewarn "which should be run. "
		ewarn "THIS IS CONSIDERED A SECURITY RISK!"
		ewarn "Please read /usr/share/doc/${PF}/SECURITY.gz for more info"
	fi
}
