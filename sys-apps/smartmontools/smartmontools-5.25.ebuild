# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/smartmontools/smartmontools-5.25.ebuild,v 1.3 2003/12/20 00:55:11 joker Exp $

DESCRIPTION="control and monitor storage systems using the Self-Monitoring, Analysis and Reporting Technology System (S.M.A.R.T.)"
HOMEPAGE="http://smartmontools.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 sparc"

S=${WORKDIR}/${P}

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
