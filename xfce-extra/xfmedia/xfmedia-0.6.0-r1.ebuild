# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfmedia/xfmedia-0.6.0-r1.ebuild,v 1.3 2005/02/04 04:22:04 bcowan Exp $

DESCRIPTION="Xfce4 media player"
HOMEPAGE="http://spuriousinterrupt.org/projects/xfmedia"
SRC_URI="http://spuriousinterrupt.org/projects/xfmedia/files/${P}.tar.bz2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~sparc ~x86"

RDEPEND=">=xfce-base/libxfce4mcs-4.2.0
	media-libs/xine-lib"

inherit xfce4
