# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/sylpheed-claws-gtkhtml/sylpheed-claws-gtkhtml-0.12.ebuild,v 1.1 2006/11/13 17:23:37 ticho Exp $

inherit eutils

MY_P="${PN#sylpheed-claws-}2_viewer-${PV}"

DESCRIPTION="Renders HTML mail using the gtkhtml2 rendering widget."
HOMEPAGE="http://claws.sylpheed.org"
SRC_URI="http://www.claws-mail.org/downloads/plugins/${MY_P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE=""
DEPEND=">=mail-client/sylpheed-claws-2.6.0
				=gnome-extra/gtkhtml-2*"

S="${WORKDIR}/${MY_P}"

src_install() {
	make DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog NEWS README

	# kill useless files
	rm -f ${D}usr/lib*/sylpheed-claws/plugins/*.{a,la}
}
