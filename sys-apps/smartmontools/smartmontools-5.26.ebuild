# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/smartmontools/smartmontools-5.26.ebuild,v 1.6 2004/07/15 02:35:18 agriffis Exp $

DESCRIPTION="control and monitor storage systems using the Self-Monitoring, Analysis and Reporting Technology System (S.M.A.R.T.)"
HOMEPAGE="http://smartmontools.sf.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64 sparc"
IUSE=""

src_compile() {
	econf || die
	emake ||die
}

src_install() {
	dosbin smart{ctl,d}
	doman *.8 *.5
	dodoc AUTHORS CHANGELOG COPYING INSTALL NEWS README TODO WARNINGS
	dodoc smartd.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/smartd.rc smartd
}

pkg_postinst() {
	einfo "You can find an example smartd.conf file in"
	einfo "/usr/share/doc/${PF}/smartd.conf.gz"
	einfo "Just place it in /etc/ as smartd.conf"
}
