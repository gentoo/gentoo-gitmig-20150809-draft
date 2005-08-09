# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/encodings/encodings-0.99.0.ebuild,v 1.2 2005/08/09 11:49:57 fmccor Exp $

# Must be before x-modular eclass is inherited
SNAPSHOT="yes"

inherit x-modular

DESCRIPTION="BigReqs prototype headers"
KEYWORDS="~sparc ~x86"
RDEPEND=""
DEPEND="${RDEPEND}
	x11-apps/mkfontscale"

src_unpack() {
	x-modular_unpack_source
	x-modular_patch_source

	sed -i -e "s:^encodingsdir =.*:encodingsdir = \$(datadir)/fonts/encodings:g" \
		${S}/Makefile.am
	sed -i -e "s:^encodingsdir =.*:encodingsdir = \$(datadir)/fonts/encodings/large:g" \
		${S}/large/Makefile.am

	x-modular_reconf_source
}
