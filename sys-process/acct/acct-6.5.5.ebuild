# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/acct/acct-6.5.5.ebuild,v 1.1 2010/11/09 19:04:20 jer Exp $

EAPI="2"

inherit eutils

DESCRIPTION="GNU system accounting utilities"
HOMEPAGE="https://savannah.gnu.org/projects/acct/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~x86"
IUSE=""

src_configure() {
	econf --enable-linux-multiformat
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
	keepdir /var/account
	newinitd "${FILESDIR}"/acct.initd acct || die
	newconfd "${FILESDIR}"/acct.confd acct
	insinto /etc/logrotate.d
	newins "${FILESDIR}"/acct.logrotate acct

	# sys-apps/sysvinit already provides this
	rm "${D}"/usr/bin/last "${D}"/usr/share/man/man1/last.1 || die

	# accton in / is only a temp workaround for #239748
	dodir /sbin
	mv "${D}"/usr/sbin/accton "${D}"/sbin/ || die
}
