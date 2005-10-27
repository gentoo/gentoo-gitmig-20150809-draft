# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libFS/libFS-0.99.1.ebuild,v 1.2 2005/10/27 03:55:02 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org FS library"
#HOMEPAGE="http://foo.bar.com/"
#SRC_URI="ftp://foo.bar.com/${P}.tar.bz2"
#LICENSE=""
#SLOT="0"
KEYWORDS="~arm ~mips ~s390 ~sparc ~x86"
#IUSE="X gnome"
RDEPEND="x11-libs/xtrans"
DEPEND="${RDEPEND}
	x11-proto/xproto
	x11-proto/fontsproto"
IUSE="ipv6"

CONFIGURE_OPTIONS="$(use_enable ipv6)"
