# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libFS/libFS-0.99.0.ebuild,v 1.3 2005/08/24 01:06:51 vapier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org FS library"
#HOMEPAGE="http://foo.bar.com/"
#SRC_URI="ftp://foo.bar.com/${P}.tar.bz2"
#LICENSE=""
#SLOT="0"
KEYWORDS="~arm ~s390 ~sparc ~x86"
#IUSE="X gnome"
RDEPEND="x11-libs/xtrans"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/fontsproto"
