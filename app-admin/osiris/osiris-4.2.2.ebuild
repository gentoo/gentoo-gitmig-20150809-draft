# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/osiris/osiris-4.2.2.ebuild,v 1.1 2006/12/12 07:38:10 dragonheart Exp $

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
	einfo "Osiris Scanning Daemon Version $VERSION for $SYSTEM"
	einfo "Copyright (c) 2006 Brian Wotring. All Rights Reserved."
	einfo ""
	einfo ""
	einfo "This installation was configured and built to run as osiris"
	einfo "     agent user name: osiris"
	einfo "management user name: osiris"
	einfo ""
	einfo "This installation was configured and built to use osiris"
	einfo "     agent root directory: /var/lib/osiris"
	einfo "management root directory: /var/lib/osiris"
	einfo ""
	einfo "The username and directory will be created during the"
	einfo "installation process if they do not already exist."
	einfo ""
	einfo "By installing this product you agree that you have read the"
	einfo "LICENSE file and will comply with its terms. "
	einfo ""
	einfo "---------------------------------------------------------------------"
	einfo ""

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
#		einfo "By default, the osiris ebuild only installs the agent."
#		einfo "To enable installing the console, please add the 'console' flag"
#		einfo "to your USE variable and re-emerge osiris."
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
	einfo "The directory /var/lib/osiris will not be removed. You may remove"
	einfo "it manually if you will not be reinstalling osiris at a later time."
}

