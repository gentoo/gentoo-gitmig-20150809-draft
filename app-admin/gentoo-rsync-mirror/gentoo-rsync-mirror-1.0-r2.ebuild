# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gentoo-rsync-mirror/gentoo-rsync-mirror-1.0-r2.ebuild,v 1.1 2003/03/19 18:42:27 tantive Exp $

S=${WORKDIR}/gentoo-rsync-mirror-${PV}
DESCRIPTION="Ebuild for setting up an gentoo rsync mirror"
HOMEPAGE="http://www.gentoo.org/doc/en/rsync.xml"
IUSE=""

DEPEND="virtual/glibc"
RDEPEND="net-misc/rsync
	dev-lang/perl"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

src_install() {
	dodir /opt/gentoo-rsync
	cp ${FILESDIR}/rsync-gentoo-portage.sh ${D}/opt/gentoo-rsync
	cp ${FILESDIR}/rsynclogparse-extended.pl ${D}/opt/gentoo-rsync
	insinto etc/rsync
	doins ${FILESDIR}/rsyncd.conf
	doins ${FILESDIR}/rsyncd.motd
	dodir /opt/gentoo-rsync/portage
	exeinto /etc/init.d
	newexe ${FILESDIR}/rsyncd.init rsyncd
}

pkg_postinst() {
	einfo "The rsync-mirror is now installed into /opt/gentoo-rsync"
	einfo "The local portage copy resists in      /opt/gentoo-rsync/portage"
	einfo "Please change /opt/gentoo-rsync/rsync-gentoo-portage.sh for"
	einfo "configuration of your main rsync server and use it so sync."
	einfo "Change /etc/rsync/rsyncd.motd to display your correct alias."
	einfo
	einfo "The service can be started using /etc/init.d/rsyncd start"
	einfo "Don't forget to add"
	einfo "00,30 * * * *      root    /opt/gentoo-rsync/rsync-gentoo-portage.sh"
	einfo "to your /etc/crontab to sync your tree every 30 minutes."
	einfo
	einfo "For more information visit: http://www.gentoo.org/doc/en/rsync.xml"
}

