# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/tmpreaper/tmpreaper-1.6.9.ebuild,v 1.7 2012/02/05 17:41:27 armin76 Exp $

inherit eutils

DESCRIPTION="A utility for removing files based on when they were last accessed"
HOMEPAGE="http://packages.debian.org/sid/tmpreaper"
SRC_URI="mirror://debian/pool/main/t/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gentoo.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	insinto /etc
	doins debian/tmpreaper.conf || die "failed to install"

	exeinto /etc/cron.daily
	newexe debian/cron.daily tmpreaper || die "failed to install cron script"
	doman debian/tmpreaper.conf.5 || die
	dodoc README ChangeLog debian/README* || die
}

pkg_postinst() {
	elog "This package installs a cron script under /etc/cron.daily"
	elog "You can configure it using /etc/tmpreaper.conf"
	elog "Consult tmpreaper.conf man page for more information"
	elog "Read /usr/share/doc/tmpreaper-1.6.9/README.security and"
	elog "remove SHOWWARNING from /etc/tmpreaper.conf afterwards"
}
