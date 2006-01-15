# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ip-sentinel/ip-sentinel-0.12.ebuild,v 1.1 2006/01/15 22:16:59 pva Exp $

inherit eutils

DESCRIPTION="Prevent unauthorized usage of IPs within the local ethernet broadcastdomain by giving an answer to ARP-requests"
HOMEPAGE="http://www.nongnu.org/ip-sentinel/"
SRC_URI="http://savannah.nongnu.org/download/ip-sentinel/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"

KEYWORDS="~x86"

IUSE=""
DEPEND=""

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README THANKS

	exeinto /etc/init.d
	newexe ${FILESDIR}/ip-sentinel.init ip-sentinel
	insinto /etc/conf.d
	newins "${FILESDIR}/ip-sentinel.conf.d" ip-sentinel
	insinto /etc
	newins "${FILESDIR}/ip-sentinel.cfg" ip-sentinel.cfg
}

pkg_preinst() {
	enewgroup ipsentinel || die "Failed to add group ipsentinel"
	enewuser ipsentinel -1 -1 -1 ipsentinel || die "Failed to add user ipsentinel"
}

pkg_postinst() {
	einfo "You can edit /etc/conf.d/ip-sentinel to customize startup daemon"
	einfo "settings."
	einfo
	einfo "Default ip-sentinel config is in /etc/ip-sentinel.cfg"
	einfo
	einfo "The ip-sentinel ebuild has chroot support."
	einfo "If you like to run ip-sentinel in chroot AND this is a new install OR"
	einfo "your ip-sentinel doesn't already run in chroot, simply run:"
	einfo "emerge --config =${CATEGORY}/${PF}"
	einfo "Before running the above command you might want to change the chroot"
	einfo "dir in /etc/conf.d/ip-sentinel, otherwise /chroot/ip-sentinel will be used."
	echo
	ewarn "And please! DO NOT START THIS DAEMON thoughtlessly."
	ewarn "If you DO this will BLOCK ALL communication inside your ethernet"
	ewarn "segment!!! If you have any doubts do not start ip-sentinel."
}

pkg_config() {
	CHROOT=`sed -n 's/^[[:blank:]]\?CHROOT="\([^"]\+\)"/\1/p' /etc/conf.d/ip-sentinel 2>/dev/null`

	if [ ! -d "${CHROOT:=/chroot/ip-sentinel}" ] ; then
		ebegin "Setting up the chroot directory"
			mkdir -m 0755 -p "${CHROOT}/etc"
			cp -R /etc/ip-sentinel.cfg "${CHROOT}/etc"
		eend

		if [ "`grep '^#[[:blank:]]\?CHROOT' /etc/conf.d/ip-sentinel`" ] ; then
			sed -e '/^#[[:blank:]]\?CHROOT/s/^#[[:blank:]]\?//' \
				-i /etc/conf.d/ip-sentinel
		fi
	else
		eerror
		eerror "${CHROOT} already exists. Quitting."
		eerror
	fi
}
