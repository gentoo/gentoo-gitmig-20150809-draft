# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imlib2_tools/imlib2_tools-0.0.0.20031013_alpha2.ebuild,v 1.2 2004/06/24 22:43:06 agriffis Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="command line programs to utilize Imlib2"

DEPEND="${DEPEND}
	>=media-libs/imlib2-1.1.0"
