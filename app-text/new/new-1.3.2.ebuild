# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/new/new-1.3.2.ebuild,v 1.2 2004/07/19 09:39:57 dholm Exp $

inherit eutils gnuconfig

DESCRIPTION="template system useful when used with a simple text editor (like vi)"
HOMEPAGE="http://www.flyn.org/"
SRC_URI="http://www.flyn.org/projects/new/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"

src_unpack() {
	unpack ${A} ; cd ${S}/src
	epatch ${FILESDIR}/${PN}-gcc-3.patch

	cd ${S} ; gnuconfig_update
}

src_install() {
	einstall || die
	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
