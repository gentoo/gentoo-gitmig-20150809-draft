# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/initng/initng-0.1.3.ebuild,v 1.1 2005/06/19 05:44:45 vapier Exp $

DESCRIPTION="A next generation init replacement"
HOMEPAGE="http://initng.thinktux.net/"
SRC_URI="http://www2.initng.thinktux.net/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~x86"
IUSE=""

src_compile() {
	for d in $(grep ^SUBDIR Makefile | sed 's:SUBDIRS =::') ; do
		emake \
			-C ${d} \
			CFLAGS="${CFLAGS}" \
			LDFLAGS="${LDFLAGS}" \
			|| die "${d} failed"
	done
}

src_install() {
	make install DESTDIR="${D}" || die
	into /
	newsbin ngcontrol/halt haltng
	newsbin ngcontrol/reboot rebootng
	dodoc README FAQ AUTHORS ChangeLog NEWS TEMPLATE_HEADER TODO \
		doc/databases.txt doc/empty.conf doc/hard.conf doc/initng.txt
}

pkg_postinst() {
	einfo "The scripts /sbin/haltng and /sbin/rebootng can be used"
	einfo "to detect which init system is running and then call"
	einfo "the proper shutdown/reboot command."
	einfo "an exprimenatal usage of sysvinit tools to make initng shutdown"
	einfo "is provided now, thx to neuron"
	echo
	einfo "remember to add init=/sbin/initng in your grub or lilo config to use initng"
	einfo "Happy testing."
}
