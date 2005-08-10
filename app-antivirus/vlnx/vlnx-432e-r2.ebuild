# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-antivirus/vlnx/vlnx-432e-r2.ebuild,v 1.6 2005/08/10 14:56:59 blubb Exp $

MY_P="${P/-/}"
S="${WORKDIR}"

DESCRIPTION="McAfee VirusScanner for Unix/Linux(Shareware)"
SRC_URI="http://download.nai.com/products/evaluation/virusscan/english/cmdline/linux/v4.32/intel/${MY_P}.tar.Z
	ftp://kane.evendata.net/pub/${PN}/check-updates.sh.gz"
HOMEPAGE="http://www.mcafeeb2b.com/"

SLOT="0"
LICENSE="VirusScan"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=" || ( sys-libs/lib-compat
			app-emulation/emul-linux-x86-compat )
	amd64? ( app-emulation/emul-linux-x86-baselibs )
	net-misc/wget
	dev-lang/perl
	app-arch/unzip"
PROVIDE="virtual/antivirus"
RESTRICT="nostrip nomirror"

src_install() {
	insinto /opt/vlnx

	doins liblnxfv.so.4
	dosym liblnxfv.so.4 /opt/vlnx/liblnxfv.so
	doins messages.dat license.dat

	insopts -m0755
	doins uvscan
	doins check-updates.sh

	insinto /opt/bin
	newins ${FILESDIR}/uvscan.sh uvscan

	dodoc *.{pdf,txt}
	doman uvscan.1

	insinto /etc/cron.daily
	newins ${FILESDIR}/uvscan.cron uvscan

	insopts -m0644
	insinto /etc/env.d
	newins ${FILESDIR}/vlnx-${PV}-envd 40vlnx

	insinto /etc
	doins ${FILESDIR}/uvscan.conf
}

pkg_postinst() {
	/opt/vlnx/check-updates.sh

	echo
	einfo "Recommended amavisd-new command line:"
	einfo "  '--secure --mime --program --mailbox -rv --summary --noboot --timeout 180'"
	echo
}
