# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/xfmedia/xfmedia-0.6.0-r1.ebuild,v 1.2 2005/01/10 18:08:42 bcowan Exp $

DESCRIPTION="Xfce4 media player"
HOMEPAGE="http://spuriousinterrupt.org/projects/xfmedia"
SRC_URI="http://spuriousinterrupt.org/projects/xfmedia/files/${P}.tar.bz2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~sparc ~x86"

XRDEPEND="media-libs/xine-lib"

inherit xfce4
