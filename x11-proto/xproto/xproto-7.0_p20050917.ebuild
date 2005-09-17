# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/xproto/xproto-7.0_p20050917.ebuild,v 1.1 2005/09/17 16:33:47 joshuabaergen Exp $

inherit versionator

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

# Fix ${S} in x-modular for pre ebuilds
MY_P="${PN}-$(get_version_component_range 1-2)"
S="${WORKDIR}/${MY_P}"

inherit x-modular

DESCRIPTION="X.Org xproto protocol headers"
#HOMEPAGE="http://foo.bar.com/"

# Snapshots don't reside on fdo servers
SRC_URI="http://dev.gentoo.org/~joshuabaergen/distfiles/${P}.tar.bz2
		mirror://gentoo/${P}.tar.bz2"

#LICENSE=""
#SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~s390 ~sh ~sparc ~x86"
#IUSE="X gnome"
#DEPEND=""
#RDEPEND=""

src_unpack() {
	x-modular_unpack_source

	x-modular_reconf_source
}
