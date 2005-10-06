# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfmedia/xfmedia-0.9.1.ebuild,v 1.1 2005/10/06 05:24:11 bcowan Exp $

DESCRIPTION="Xfce4 media player"
HOMEPAGE="http://spuriousinterrupt.org/projects/xfmedia"
SRC_URI="http://spuriousinterrupt.org/projects/xfmedia/files/${P}.tar.bz2"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="dbus"

RDEPEND=">=xfce-base/libxfce4mcs-4.2.0
	xfce-extra/exo
	dbus? ( sys-apps/dbus )
	media-libs/xine-lib
	media-libs/taglib"

inherit xfce4
