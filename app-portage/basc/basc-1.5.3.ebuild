# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/basc/basc-1.5.3.ebuild,v 1.3 2005/01/19 23:01:30 squash Exp $

# ebuild contributed by Alexander Mieland and Daniel Herzog

inherit eutils toolchain-funcs

DESCRIPTION="Buildtime And Statistics Client for http://www.gentoo-stats.org"
HOMEPAGE="http://www.gentoo-stats.org"
SRC_URI="http://www.gentoo-stats.org/download/${P}.tar.gz"

KEYWORDS="x86 ~hppa ppc amd64 ~ppc64"
SLOT="0"
LICENSE="GPL-2"

IUSE=""

RDEPEND="app-portage/gentoolkit
	dev-lang/perl
	dev-perl/DateManip
	net-misc/wget
	sys-devel/gcc
	sys-apps/sed
	sys-apps/grep
	app-arch/gzip
	sys-apps/diffutils
	>=sys-apps/uhinv-0.4"

pkg_setup() {
	enewgroup stats
	enewuser stats -1 /bin/false /tmp stats
}

src_compile() {
	sed -i "s:/usr/local:/usr:g" client/basc client/hgenlop
	useq x86 && $(tc-getCC) ${CFLAGS} -o client/smt-detect client/smt-detect.c >/dev/null 2>&1
}

src_install() {
	exeinto /usr/bin
	doexe client/basc client/hgenlop client/urandom.sh

	useq x86 && doexe client/smt-detect

	dodoc README ChangeLog TEAM
	dodir /etc/basc
	touch ${D}/etc/basc/basc.conf

	fowners root:stats /etc/basc
	fperms ug+w /etc/basc

	fowners root:stats /etc/basc/basc.conf
	fperms ug+w /etc/basc/basc.conf
}

pkg_postinst() {
	local GU=`/usr/bin/hgenlop -nt gcc`
	echo "GU=\"${GU}\"" >> /etc/basc/basc.conf

	draw_line
	einfo
	einfo "The Gentoo Buildtime and Statistics client can be started by"
	einfo "typing:"
	einfo ""
	einfo "  \"basc\""
	einfo ""
	einfo "Note:"
	einfo ""
	einfo "You have to be in the stats group to use the client!"
	einfo "A user can be added to the stats group by executing:"
	einfo ""
	einfo "  \"usermod -G \$(groups <ME> | sed -e 's/ /,/g'),stats <ME>\""
	einfo ""
	einfo "Replace <ME> with your username on the system."
	einfo "After a login, you are ready to use the client."
	einfo ""
	einfo "If you want to automatically launch the client every 24h,"
	einfo "you must set up a cronjob for the stats user or a user in"
	einfo "the stats group."
	einfo ""
	einfo "For example:"
	einfo ""
	einfo "   \"0 0 * * * /usr/bin/basc -q -y >/dev/null 2>&1\""
	einfo ""
	einfo "will start the client every day at 00:00am"
	einfo
	draw_line
	ebeep
}
