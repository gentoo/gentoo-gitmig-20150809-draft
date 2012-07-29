# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-forensics/lynis/lynis-1.2.9.ebuild,v 1.5 2012/07/29 16:42:40 armin76 Exp $

DESCRIPTION="Security and system auditing tool"
HOMEPAGE="http://www.rootkit.nl/projects/lynis.html"
SRC_URI="http://www.rootkit.nl/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND="app-shells/bash"

src_install() {
	insinto /usr/share/${PN}
	doins -r db/ include/ plugins/ || die "failed to install lynis base files"

	# Lynis will ignore plugins with permissions other than 0400.
	fperms 0400 /usr/share/${PN}/plugins/plugin_{access_files,compliance_pci,homedirs,webserver_data} || die

	dosbin lynis || die "dosbin failed"

	insinto /etc/${PN}
	doins default.prf || die "failed to install default.prf"

	doman lynis.8 || die "doman failed"
	dodoc CHANGELOG FAQ README dev/TODO

	# Remove the old one during the next stabilize progress
	exeinto /etc/cron.daily
	newexe "${FILESDIR}"/lynis.cron-new lynis || die "failed to install cron script"
}

pkg_postinst() {
	einfo
	einfo "A cron script has been installed to ${ROOT}etc/cron.daily/lynis."
	einfo
}
