# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gentoo-rsync-mirror/gentoo-rsync-mirror-1.0-r5.ebuild,v 1.2 2006/08/27 10:14:46 tantive Exp $

DESCRIPTION="Ebuild for setting up a Gentoo rsync mirror"
HOMEPAGE="http://www.gentoo.org/doc/en/rsync.xml"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~alpha ~ppc ~sparc ~x86 ~hppa ~ppc64"
IUSE=""

DEPEND="virtual/libc"
RDEPEND="net-misc/rsync
	dev-lang/perl"

S=${WORKDIR}/gentoo-rsync-mirror-${PV}

src_install() {
	dodir /opt/gentoo-rsync
	cp ${FILESDIR}/rsync-gentoo-portage.sh ${D}/opt/gentoo-rsync
	cp ${FILESDIR}/rsynclogparse-extended.pl ${D}/opt/gentoo-rsync
	insinto etc/rsync
	doins ${FILESDIR}/rsyncd.conf
	doins ${FILESDIR}/rsyncd.motd
	doins ${FILESDIR}/gentoo-mirror.conf
	dodir /opt/gentoo-rsync/portage
}

pkg_postinst() {
	einfo "The rsync-mirror is now installed into /opt/gentoo-rsync"
	einfo "The local portage copy resides in      /opt/gentoo-rsync/portage"
	einfo "Please change /opt/gentoo-rsync/rsync-gentoo-portage.sh for"
	einfo "configuration of your main rsync server and use it to sync."
	einfo "Change /etc/rsync/rsyncd.motd to display your correct alias."
	einfo
	einfo "RSYNC_OPTS="--config=/etc/rsync/rsyncd.conf" needs"
	einfo "to be set in /etc/conf.d/rsyncd to make allow syncing."
	einfo
	einfo "The service can be started using /etc/init.d/rsyncd start"
	einfo "If you are setting up an official mirror, don't forget to add"
	einfo "00,30 * * * *      root    /opt/gentoo-rsync/rsync-gentoo-portage.sh"
	einfo "to your /etc/crontab to sync your tree every 30 minutes."
	einfo
	einfo "If you are setting up a private (unofficial) mirror, you can add"
	einfo "0 3 * * *	root	/opt/gentoo-rsync/rsync-gentoo-portage.sh"
	einfo "to your /etc/crontab to sync your tree once per day."
	einfo
	einfo "****IMPORTANT****"
	einfo "If you are setting up a private mirror, DO NOT sync against the"
	einfo "gentoo.org official rotations more than once a day.  Doing so puts"
	einfo "you at risk of having your IP address banned from the rotations."
	einfo
	einfo "For more information visit: http://www.gentoo.org/doc/en/rsync.xml"
}
