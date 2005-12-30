# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/liblbxutil/liblbxutil-1.0.0.ebuild,v 1.3 2005/12/30 02:21:20 vapier Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org lbxutil library"
#HOMEPAGE="http://foo.bar.com/"
#SRC_URI="ftp://foo.bar.com/${P}.tar.bz2"
#LICENSE=""
#SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~mips ~ppc ~s390 ~sh ~sparc ~x86"
#IUSE="X gnome"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-proto/xextproto"
