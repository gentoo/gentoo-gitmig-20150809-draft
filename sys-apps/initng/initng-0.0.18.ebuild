# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/initng/initng-0.0.18.ebuild,v 1.1 2005/05/20 03:57:46 vapier Exp $

DESCRIPTION="A next generation init replacement"
HOMEPAGE="http://jw.dyndns.org/initng/"
SRC_URI="http://jw.dyndns.org/initng/download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~s390 ~x86"
IUSE=""

DEPEND="!sys-apps/sysvinit"

src_compile() {
	for d in ngcontrol src ; do
		emake -C ${d} CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" || die "${d} failed"
	done
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc README AUTHORS ChangeLog NEWS TEMPLATE_HEADER TODO doc/databases.txt doc/empty.conf doc/hard.conf
}

pkg_postinst() {
	einfo "remember to add init=/sbin/initng in your grub or lilo config to use initng"
	einfo "Happy testing."
}
