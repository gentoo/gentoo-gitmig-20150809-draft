# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/basc/basc-1.5.1.ebuild,v 1.2 2004/12/31 00:48:16 dsd Exp $

inherit eutils toolchain-funcs

DESCRIPTION="client for Buildtime And Statistics Client (Unofficial Gentoo Project)"
HOMEPAGE="http://www.gentoo-stats.org/"
SRC_URI="http://www.gentoo-stats.org/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="app-portage/gentoolkit
	dev-lang/perl
	dev-perl/DateManip
	net-misc/wget
	sys-devel/gcc
	sys-apps/sed
	sys-apps/grep
	app-arch/gzip
	>=sys-apps/uhinv-0.4"

pkg_setup() {
	enewgroup stats
	enewuser stats -1 /bin/false /tmp stats
}

src_compile() {
	sed -i "s:/usr/local:/usr:g" client/basc client/hgenlop
	$(tc-getCC) ${CFLAGS} -o client/smt-detect client/smt-detect.c || die "build failed"
}

src_install() {
	dobin client/basc client/hgenlop client/smt-detect client/urandom.sh || die "dobin"
	dodoc README ChangeLog TEAM
	dodir /etc/basc
	touch "${D}"/etc/basc/basc.conf

	fowners root:stats /etc/basc
	fperms ug+w /etc/basc

	fowners root:stats /etc/basc/basc.conf
	fperms ug+w /etc/basc/basc.conf
}

pkg_postinst() {
	local GU=`/usr/bin/hgenlop -nt gcc`
	echo "GU=\"${GU}\"" >> /etc/basc/basc.conf

	ewarn "WARNING: If you upgraded from an earlier version, you must"
	ewarn "perform a forced upgrade from a console now. Please follow"
	ewarn "the instructions below to do this."
	ewarn "You must also update your crontab to use -y or -n."
	einfo
	einfo "The Gentoo Buildtime and Statistics client can be started by"
	einfo "typing:"
	einfo ""
	einfo "  \"basc -u\"."
	einfo ""
	einfo "Note: You have to be in the stats group to use the client!"
	einfo ""
	einfo "If you want to automatically launch the client every 24h,"
	einfo "you must set up a cronjob for the stats user or a user in"
	einfo "the stats group."
	einfo ""
	einfo "For example:"
	einfo ""
	einfo "   \"0 0 * * * /usr/bin/basc -q -n >/dev/null 2>&1\""
	einfo ""
	einfo "will start the client every day at 00:00am"
	einfo "Use -y instead of -n if you want X/kernel/USE info sent"
	einfo "to the server."
	einfo
}
