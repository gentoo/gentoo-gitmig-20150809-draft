# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXmu/libXmu-0.99.1-r1.ebuild,v 1.2 2005/11/04 17:06:35 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org Xmu library"
#HOMEPAGE="http://foo.bar.com/"
#SRC_URI="ftp://foo.bar.com/${P}.tar.bz2"
#LICENSE=""
#SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~s390 ~sh ~sparc ~x86"
#IUSE="X gnome"
RDEPEND="x11-libs/libXt
	x11-libs/libXext
	x11-libs/libX11
	x11-proto/xproto"
DEPEND="${RDEPEND}"
IUSE="ipv6"

CONFIGURE_OPTIONS="$(use_enable ipv6)"
