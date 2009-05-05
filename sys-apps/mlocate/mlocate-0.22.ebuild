# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mlocate/mlocate-0.22.ebuild,v 1.1 2009/05/05 14:47:23 fauli Exp $

inherit eutils

DESCRIPTION="Merging locate is an utility to index and quickly search for files"
HOMEPAGE="https://fedorahosted.org/mlocate/"
SRC_URI="https://fedorahosted.org/releases/m/l/mlocate/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="!sys-apps/slocate
	!sys-apps/rlocate"

pkg_setup() {
	enewgroup locate
}

src_compile() {
	econf || die "econf failed"
	emake groupname=locate || die "emake failed"
}

src_install() {
	emake groupname=locate DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README NEWS

	insinto /etc
	doins "${FILESDIR}/updatedb.conf"
	fperms 0644 /etc/updatedb.conf

	insinto /etc
	doins "${FILESDIR}/mlocate-cron.conf"
	fperms 0644 /etc/mlocate-cron.conf

	insinto /etc/cron.daily
	newins "${FILESDIR}/mlocate.cron-r1" mlocate
	fperms 0755 /etc/cron.daily/mlocate

	fowners 0:locate /usr/bin/locate
	fperms go-r,g+s /usr/bin/locate

	chown -R 0:locate "${D}/var/lib/mlocate"
	fperms 0750 /var/lib/mlocate
	keepdir /var/lib/mlocate
}

src_test() {
	if has userpriv ${FEATURES} && ! has usersandbox ${FEATURES}; then
		make check-local || die "test suite failed"
	else
		ewarn "Activate FEATURES=userpriv and deactivate FEATURES=usersandbox to run testsuite."
	fi
}

pkg_postinst() {
	elog "Note that the /etc/updatedb.conf file is generic"
	elog "Please customize it to your system requirements"
}
