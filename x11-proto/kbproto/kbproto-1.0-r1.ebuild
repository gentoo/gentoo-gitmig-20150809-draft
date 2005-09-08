# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/kbproto/kbproto-1.0-r1.ebuild,v 1.1 2005/09/08 04:08:26 spyderous Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

PATCHES="${FILESDIR}/add-xkbbindirectory.patch"
DESCRIPTION="X.Org KB protocol headers"
#HOMEPAGE="http://foo.bar.com/"
#SRC_URI="ftp://foo.bar.com/${P}.tar.bz2"
#LICENSE=""
#SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~s390 ~sh ~sparc ~x86"
#IUSE="X gnome"
#DEPEND=""
#RDEPEND=""
