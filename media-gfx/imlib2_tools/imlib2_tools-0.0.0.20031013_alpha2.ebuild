# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/imlib2_tools/imlib2_tools-0.0.0.20031013_alpha2.ebuild,v 1.1 2003/10/14 03:17:53 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="command line programs to utilize Imlib2"

DEPEND="${DEPEND}
	>=media-libs/imlib2-1.1.0"
