# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/xproto/xproto-7.0.4.ebuild,v 1.1 2005/12/17 21:16:30 joshuabaergen Exp $

# Must be before x-modular eclass is inherited
#SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="X.Org xproto protocol headers"
KEYWORDS="~amd64 ~arm ~mips ~ppc ~s390 ~sh ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}"

src_unpack() {
	x-modular_unpack_source

	x-modular_reconf_source
}
