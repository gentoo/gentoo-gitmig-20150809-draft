# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/epsilon/epsilon-0.0.2.20031213.ebuild,v 1.1 2003/12/13 16:16:05 vapier Exp $

inherit enlightenment

DESCRIPTION="nice thumbnail generator"

DEPEND="${DEPEND}
	media-libs/imlib2
	media-libs/epeg
	media-libs/libpng"
