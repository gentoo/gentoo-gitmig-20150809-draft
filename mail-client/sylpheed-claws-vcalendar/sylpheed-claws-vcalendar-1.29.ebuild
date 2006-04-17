# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-vcalendar/sylpheed-claws-vcalendar-1.29.ebuild,v 1.3 2006/04/17 18:41:54 corsair Exp $

MY_P="${P##sylpheed-claws-}"
MY_PN="${PN##sylpheed-claws-}"
SC_BASE="2.0.0"
SC_BASE_NAME="sylpheed-claws-extra-plugins-${SC_BASE}"

DESCRIPTION="Plugin for sylpheed-claws to support the vCalendar meeting format"
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="mirror://sourceforge/sylpheed-claws/${SC_BASE_NAME}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 x86"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-${SC_BASE}"

S="${WORKDIR}/${SC_BASE_NAME}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f ${D}/usr/lib*/sylpheed-claws/plugins/*.{a,la}

	# going to conflict with libical
	rm -f ${D}/usr/include/ical.h
}
