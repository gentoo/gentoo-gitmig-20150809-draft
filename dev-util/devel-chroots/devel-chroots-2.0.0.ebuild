# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devel-chroots/devel-chroots-2.0.0.ebuild,v 1.2 2007/03/21 17:10:19 armin76 Exp $

DESCRIPTION="Gentoo Developer chroots installation/configuration"
HOMEPAGE="http://dev.gentoo.org/~pappy/projects/Gentoo/devel-chroots"

SRC_URI="http://user.noxa.de/~pappy/mirror/gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc x86"

IUSE="minimal"

RDEPEND="app-misc/screen"

src_install() {
	doconfd "${S}/etc/conf.d/${PN}"
	doinitd "${S}/etc/init.d/${PN}"

	local target="install"

	use minimal && target="minimal"

	emake ${target} DESTDIR="${D}" || die "emake ${target} failed"
}

pkg_postinst() {
	if use minimal
	then
		elog "You need to provide your own config files and change"
		elog "the location of the chroot configuration directory"
		elog "in the /etc/conf.d/devel-chroots configuration file."
	fi
}

