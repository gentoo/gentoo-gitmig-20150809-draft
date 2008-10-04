# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-nntp/nzbget/nzbget-0.5.1.ebuild,v 1.1 2008/10/04 16:40:09 swegener Exp $

EAPI="1"

inherit eutils

DESCRIPTION="A command-line based binary newsgrabber supporting .nzb files"
HOMEPAGE="http://nzbget.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE="debug ncurses parcheck"

DEPEND="dev-libs/libxml2
	parcheck? (
		app-arch/libpar2
		dev-libs/libsigc++:2
	)
	ncurses? ( sys-libs/ncurses )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed \
		-e 's:^$MAINDIR=.*:$MAINDIR=/var/lib/nzbget:' \
		-e 's:^LockFile=.*:LockFile=/var/run/nzbget/nzbget.pid:' \
		-e 's:^LogFile=.*:LogFile=/var/log/nzbget/nzbget.log:' \
		"${S}"/nzbget.conf.example >"${S}"/nzbgetd.conf.example \
		|| die "sed nzbgetd.conf.example failed"
}

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable ncurses curses) \
		$(use_enable parcheck) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	insinto /etc
	newins nzbget.conf.example nzbget.conf || die "newins failed"
	newins nzbgetd.conf.example nzbgetd.conf || die "newins failed"

	keepdir /var/lib/nzbget/{dst,nzb,queue,tmp}
	keepdir /var/{log,run}/nzbget

	newinitd "${FILESDIR}"/nzbget.initd nzbget
	newconfd "${FILESDIR}"/nzbget.confd nzbget

	dodoc AUTHORS ChangeLog README nzbget.conf.example || die "dodoc failed"
}

pkg_postinst() {
	enewgroup nzbget
	enewuser nzbget -1 -1 /var/lib/nzbget nzbget

	chown nzbget:nzbget "${ROOT}"/var/lib/nzbget/{dst,nzb,queue,tmp}
	chmod 750 "${ROOT}"/var/lib/nzbget/{queue,tmp}
	chmod 770 "${ROOT}"/var/lib/nzbget/{dst,nzb}

	chown nzbget:nzbget "${ROOT}"/var/{log,run}/nzbget
	chmod 750 "${ROOT}"/var/{log,run}/nzbget

	chown root:nzbget "${ROOT}"/etc/nzbgetd.conf
	chmod 640 "${ROOT}"/etc/nzbgetd.conf

	elog
	elog "Please add users that you want to be able to use the system-wide"
	elog "nzbget daemon to the nzbget group. To access the daemon run nzbget"
	elog "with the --configfile /etc/nzbgetd.conf option."
	elog
}
