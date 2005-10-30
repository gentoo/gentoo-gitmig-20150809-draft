# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libICE/libICE-0.99.0.ebuild,v 1.10 2005/10/30 17:28:40 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org ICE library"
#HOMEPAGE="http://foo.bar.com/"
#SRC_URI="ftp://foo.bar.com/${P}.tar.bz2"
#LICENSE=""
#SLOT="0"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~s390 ~sh ~sparc ~x86"
IUSE="ipv6"
RDEPEND="x11-libs/xtrans
	x11-proto/xproto"
DEPEND="${RDEPEND}"

CONFIGURE_OPTIONS="$(use_enable ipv6)"
