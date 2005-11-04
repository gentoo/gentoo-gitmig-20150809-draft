# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libxkbui/libxkbui-0.99.0.ebuild,v 1.7 2005/11/04 17:00:27 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xkbui library"
#HOMEPAGE="http://foo.bar.com/"
#SRC_URI="ftp://foo.bar.com/${P}.tar.bz2"
#LICENSE=""
#SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~s390 ~sparc ~x86"
#IUSE="X gnome"
RDEPEND="x11-libs/libXt
	x11-libs/libxkbfile
	x11-proto/kbproto"
DEPEND="${RDEPEND}"
