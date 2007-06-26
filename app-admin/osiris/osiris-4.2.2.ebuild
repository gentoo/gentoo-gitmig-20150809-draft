# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/osiris/osiris-4.2.2.ebuild,v 1.3 2007/06/26 01:31:51 mr_bones_ Exp $

inherit eutils autotools

DESCRIPTION="File integrity verification system"
HOMEPAGE="http://osiris.shmoo.com/"
SRC_URI="http://osiris.shmoo.com/data/${P}.tar.gz
	http://osiris.shmoo.com/data/modules/mod_uptime.tar.gz
	http://osiris.shmoo.com/data/modules/mod_dns.tar.gz
	http://osiris.shmoo.com/data/modules/mod_nvram.tar.gz"
#	http://osiris.shmoo.com/data/modules/mod_ports.tar.gz"

LICENSE="OSIRIS"
SLOT="0"
KEYWORDS="~x86 ~ppc"
#IUSE="noagent console"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.8c
	=sys-libs/db-4.2*"

pkg_setup()
{
	enewgroup osiris
	enewuser osiris -1 -1 /var/lib/osiris osiris
}

src_unpack()
{
	unpack ${P}.tar.gz
	epatch "${FILESDIR}"/${P}-externaldb.patch
	cd "${S}"
	./bootstrap
	#eautomake
	cd "${WORKDIR}"
	unpack mod_uptime.tar.gz
	unpack mod_dns.tar.gz
	unpack mod_nvram.tar.gz
#	unpack mod_ports.tar.gz
#	Add the above modules
	mv "${S}"/../mod_* "${S}"/src/osirisd/modules/
}

src_compile()
{
	econf --prefix=/var/lib --enable-fancy-cli=yes || die "configure failed."
#	if  ! use noagent ; then
		emake agent || die "agent build failed"
#	fi
#	if use console ; then
		emake console || die "management build failed"
#	fi
}

src_install() {
	elog "Osiris Scanning Daemon Version $VERSION for $SYSTEM"
	elog "Copyright (c) 2006 Brian Wotring. All Rights Reserved."
	elog ""
	elog ""
	elog "This installation was configured and built to run as osiris"
	elog "     agent user name: osiris"
	elog "management user name: osiris"
	elog ""
	elog "This installation was configured and built to use osiris"
	elog "     agent root directory: /var/lib/osiris"
	elog "management root directory: /var/lib/osiris"
	elog ""
	elog "The username and directory will be created during the"
	elog "installation process if they do not already exist."
	elog ""
	elog "By installing this product you agree that you have read the"
	elog "LICENSE file and will comply with its terms. "
	elog ""
	elog "---------------------------------------------------------------------"
	elog ""

#	if ! use noagent ; then
		dosbin src/osirisd/osirisd
		fowners root:0 /usr/sbin/osirisd
		fperms 0755 /usr/sbin/osirisd
		newinitd "${FILESDIR}"/osirisd-${PV} osirisd
		newconfd "${FILESDIR}"/osirisd_confd-${PV} osirisd
#	fi

#	if use console; then
		dosbin src/cli/osiris
		fowners root:0 /usr/sbin/osiris
		fperms 0755 /usr/sbin/osiris

		dosbin src/osirismd/osirismd
		fowners osiris:osiris /usr/sbin/osirismd
		fperms 4755 /usr/sbin/osirismd

		newinitd "${FILESDIR}"/osirismd-${PV} osirismd
		newconfd "${FILESDIR}"/osirismd_confd-${PV} osirismd
#	fi

	dodir /var/run
	dodir /var/lib
	diropts -o osiris -g osiris -m0750
	dodir /var/lib/osiris
	dodir /var/run/osiris
	keepdir /var/run/osiris
#	if use console ; then
		cp -rf "${S}"/src/configs "${D}"/var/lib/osiris/
		chown -R osiris:osiris "${D}"/var/lib/osiris/*
		chmod -R 0750 "${D}"/var/lib/osiris/*
#	fi
}

#pkg_postinst()
#{
#	if ! use console ; then
#		elog "By default, the osiris ebuild only installs the agent."
#		elog "To enable installing the console, please add the 'console' flag"
#		elog "to your USE variable and re-emerge osiris."
#	fi
#}

pkg_postrm()
{
	# PID directory should not clutter the
	# system
	rm -rf /var/run/osiris

	# Allow the user to decide if certs,
	# configs, and other things should
	# be
	# removed.
	elog "The directory /var/lib/osiris will not be removed. You may remove"
	elog "it manually if you will not be reinstalling osiris at a later time."
}

