# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/smartmontools/smartmontools-5.0.45.ebuild,v 1.5 2003/03/10 17:19:04 vapier Exp $

MY_P="${PN}-5.0-45"
DESCRIPTION="control and monitor storage systems using the Self-Monitoring, Analysis and Reporting Technology System (S.M.A.R.T.)"
HOMEPAGE="http://smartmontools.sourceforge.net/"
SRC_URI="mirror://sourceforge/smartmontools/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc"

S=${WORKDIR}/${MY_P}

src_compile() {
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	dosbin smart{ctl,d}
	doman *.8 *.5
	dodoc CHANGELOG WARNINGS README TODO VERSION smartd.conf

	exeinto /etc/init.d
	newexe ${FILESDIR}/smartd.rc smartd
}

pkg_postinst() {
	einfo "You can find an example smartd.conf file in"
	einfo "/usr/share/doc/${PF}/smartd.conf.gz"
	einfo "Just place it in /etc/ as smartd.conf"
}
