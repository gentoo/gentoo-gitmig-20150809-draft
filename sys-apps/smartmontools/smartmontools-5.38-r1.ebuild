# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/smartmontools/smartmontools-5.38-r1.ebuild,v 1.1 2009/08/26 23:08:15 robbat2 Exp $

inherit flag-o-matic

DESCRIPTION="control and monitor storage systems using the Self-Monitoring, Analysis and Reporting Technology System (S.M.A.R.T.)"
HOMEPAGE="http://smartmontools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="static minimal"

RDEPEND="!minimal? ( virtual/mailx )"
DEPEND=""

src_compile() {
	use minimal && einfo "Skipping the monitoring daemon for minimal build."
	use static && append-ldflags -static
	econf || die
	emake || die
}

src_install() {
	dosbin smartctl || die "dosbin smartctl"
	dodoc AUTHORS CHANGELOG NEWS README TODO WARNINGS
	doman smartctl.8
	if ! use minimal; then
	dosbin smartd || die "dosbin smartd"
		doman smartd*.[58]
		newdoc smartd.conf smartd.conf.example
		docinto examplescripts
		dodoc examplescripts/*
		rm -f "${D}"/usr/share/doc/${PF}/examplescripts/Makefile*

		insinto /etc
		doins smartd.conf

		newinitd "${FILESDIR}"/smartd.rc smartd
		newconfd "${FILESDIR}"/smartd.confd smartd
	fi
}
