# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/font-alias/font-alias-0.99.0.ebuild,v 1.3 2005/08/15 15:42:38 herbs Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="BigReqs prototype headers"
KEYWORDS="~amd64 ~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/mkfontscale"

src_unpack() {
	x-modular_unpack_source
	x-modular_patch_source

	for dir in 100dpi 75dpi cyrillic misc; do
		sed -i -e "s:^aliasdir =.*:aliasdir = \$(datadir)/fonts/${dir}:g" \
			${S}/${dir}/Makefile.am
	done

	x-modular_reconf_source
}
