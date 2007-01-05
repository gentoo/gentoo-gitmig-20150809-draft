# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gaim-rhythmbox/gaim-rhythmbox-2.0_beta5.ebuild,v 1.2 2007/01/05 04:43:01 dirtyepic Exp $

MY_PV="2.0beta3"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="automatically update your Gaim profile with current info from Rhythmbox"
HOMEPAGE="http://jon.oberheide.org/projects/gaim-rhythmbox"
SRC_URI="http://jon.oberheide.org/projects/gaim-rhythmbox/downloads/${MY_P}.tar.gz"

GAIM_API="1.9.9"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=net-im/gaim-${GAIM_API}
	>=media-sound/rhythmbox-0.9
	>=sys-apps/dbus-0.35"
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	sed -i -e 's:--variable=prefix`/lib:--variable=libdir`:' \
		${S}/configure{.ac,} || die "sed failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
