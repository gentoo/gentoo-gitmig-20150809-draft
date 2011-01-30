# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mlocate/mlocate-0.23.1-r1.ebuild,v 1.1 2011/01/30 13:16:50 scarabeus Exp $

EAPI="3"

inherit eutils

DESCRIPTION="Merging locate is an utility to index and quickly search for files"
HOMEPAGE="https://fedorahosted.org/mlocate/"
SRC_URI="https://fedorahosted.org/releases/m/l/mlocate/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND="!sys-apps/slocate
	!sys-apps/rlocate"
DEPEND="app-arch/xz-utils"

pkg_setup() {
	enewgroup locate
}

src_compile() {
	emake groupname=locate || die
}

src_install() {
	emake groupname=locate DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README NEWS

	insinto /etc
	doins "${FILESDIR}"/updatedb.conf || die
	doins "${FILESDIR}"/mlocate-cron.conf || die
	fperms 0644 /etc/{updatedb,mlocate-cron}.conf

	insinto /etc/cron.daily
	newins "${FILESDIR}/mlocate.cron-r2" mlocate
	fperms 0755 /etc/cron.daily/mlocate

	fowners 0:locate /usr/bin/locate
	fperms go-r,g+s /usr/bin/locate

	keepdir /var/lib/mlocate
	chown -R 0:locate "${D}"/var/lib/mlocate
	fperms 0750 /var/lib/mlocate
}

pkg_postinst() {
	elog "The database for the locate command is generated daily by a cron job,"
	elog "if you install for the first time you can run the updatedb command manually now."
	elog
	elog "Note that the /etc/updatedb.conf file is generic,"
	elog "please customize it to your system requirements."
}
