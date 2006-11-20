# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-antivirus/vlnx/vlnx-4510e.ebuild,v 1.1 2006/11/20 17:28:10 drizzt Exp $

S="${WORKDIR}"

DESCRIPTION="McAfee VirusScanner for Unix/Linux(Shareware)"
SRC_URI="http://download.nai.com/products/evaluation/virusscan/english/cmdline/linux/v5.10/vlp${PV}.tar.Z
	mirror://gentoo/virusscan_updater.sh.gz"
HOMEPAGE="http://www.mcafeeb2b.com/"

SLOT="0"
LICENSE="VirusScan"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=" || ( sys-libs/lib-compat
			app-emulation/emul-linux-x86-compat )
	amd64? ( app-emulation/emul-linux-x86-baselibs )
	net-misc/wget"
DEPEND=""

PROVIDE="virtual/antivirus"
RESTRICT="binchecks nostrip nomirror"

src_install() {
	insinto /opt/vlnx
	doins "${FILESDIR}"/uvscan.cron

	doins messages.dat license.dat

	insopts -m0755
	doins uvscan liblnxfv.so.4
	dosym liblnxfv.so.4 /opt/vlnx/liblnxfv.so
	doins virusscan_updater.sh

	insinto /opt/bin
	newins "${FILESDIR}"/uvscan.sh uvscan

	dodoc *.{pdf,txt}
	doman uvscan.1

	insinto /etc
	doins "${FILESDIR}"/uvscan.conf
}

pkg_postinst() {
	ebegin "Downloading DAT files (this may take a few minutes)"
	/opt/vlnx/virusscan_updater.sh
	eend $?

	echo
	einfo "Recommended amavisd-new command line:"
	einfo "  '--secure --mime --program --mailbox -rv --summary --noboot --timeout 180'"
	echo
	einfo "If you wish to have your filesystem scanned for malware daily, put file"
	einfo "/opt/vlnx/uvscan.cron into /etc/cron.daily/"
	einfo "Note that this script is set to remove infected files silently."
	echo
}
