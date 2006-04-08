# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfmedia/xfmedia-0.9.1-r2.ebuild,v 1.2 2006/04/08 21:28:04 dostrow Exp $

inherit eutils xfce42

DESCRIPTION="Xfce4 media player"
HOMEPAGE="http://spuriousinterrupt.org/projects/xfmedia"
SRC_URI="http://spuriousinterrupt.org/projects/xfmedia/files/${P}.tar.bz2"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXtst )
	virtual/x11 )
	>=xfce-base/libxfce4mcs-4.2.2-r1
	xfce-extra/exo
	sys-apps/dbus
	media-libs/xine-lib
	media-libs/taglib"
DEPEND="${RDEPEND}
	|| ( ( x11-libs/libX11
	x11-libs/libXt
	x11-proto/xextproto
	x11-proto/xproto )
	virtual/x11 )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/xfmedia-dbus-0.6-support.patch
}
