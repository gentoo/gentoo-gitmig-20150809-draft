# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-vcalendar/sylpheed-claws-vcalendar-1.90.ebuild,v 1.1 2006/11/13 18:04:21 ticho Exp $

inherit eutils

MY_P="${P#sylpheed-claws-}"

DESCRIPTION="Plugin for sylpheed-claws to support the vCalendar meeting format"
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-2.6.0"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f ${D}/usr/lib*/sylpheed-claws/plugins/*.{a,la}

	# going to conflict with libical
	rm -f ${D}/usr/include/ical.h
}
