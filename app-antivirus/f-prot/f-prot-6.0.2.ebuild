# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-antivirus/f-prot/f-prot-6.0.2.ebuild,v 1.2 2009/04/04 14:43:18 maekke Exp $

inherit eutils

IUSE=""

MY_P_X86="fp-Linux-i686-ws-${PV}"
MY_P_X64="fp-Linux-x86_64-ws-${PV}"
MY_P_PPC="fp-Linux-ppc-ws-${PV}"
MY_P_X86FBSD="fp-FreeBSD-i386-ws-${PV}"
MY_P_X86SOL="fp-SunOS-i386-ws-${PV}"
MY_P_SPARCSOL="fp-SunOS-sparc-ws-${PV}"
S=${WORKDIR}/${PN}

DESCRIPTION="Frisk Software's f-prot virus scanner"
HOMEPAGE="http://www.f-prot.com/"
SRC_URI="x86? ( http://files.f-prot.com/files/unix-trial/${MY_P_X86}.tar.gz )
	amd64? ( http://files.f-prot.com/files/unix-trial/${MY_P_X64}.tar.gz )"
DEPEND=""
RDEPEND=""
PROVIDE="virtual/antivirus"

SLOT="0"
LICENSE="F-PROT-AV
	elibc_glibc? ( LGPL-2.1 )
	elibc_FreeBSD? ( BSD-2 )"
KEYWORDS="amd64 -ppc -sparc x86 -x86-fbsd"

src_install() {
	insinto /opt/f-prot
	insopts -m 755

	doins fpscan
	doins fpupdate

	insopts -m 644

	doins license.key
	doins product.data
	doins product.data.default
	doins *.def

	dodir /usr/bin
	dosym /opt/f-prot/fpscan /usr/bin/fpscan

	newins f-prot.conf.default f-prot.conf
	dodir /etc
	dosym /opt/f-prot/f-prot.conf /etc/f-prot.conf

	keepdir /var/tmp/f-prot

	dodoc doc/CHANGES
	dodoc README
	dohtml doc/html/*
	doman doc/man/*
}

pkg_postinst() {
	# upstream complains about DoS-updates, so spread over the hour ;)
	local min=$(date +%S)
	elog "f-prot has changed SIGNIFICANTLY since the previous version in"
	elog "Portage (4.6.7).  Most notably the binary names and their command"
	elog "line options have changed.  Review all of your scripts, and be"
	elog "sure to read ${ROOT}usr/share/doc/${P}/README."
	elog
	elog "Remember to run /opt/f-prot/fpupdate regularly to keep the virus"
	elog "database up to date.  Recommended method is to use cron.  See"
	elog "manpages for cron(8) and crontab(5) for more info."
	elog "An example crontab entry, causing fpupdate to run every night"
	elog "${min#0} minutes after 4AM:"
	elog
	elog "${min} 4 * * * /opt/f-prot/fpupdate >/dev/null"
}
