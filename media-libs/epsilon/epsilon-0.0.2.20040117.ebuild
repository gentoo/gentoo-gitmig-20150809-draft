# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/epsilon/epsilon-0.0.2.20040117.ebuild,v 1.1 2004/01/20 05:33:48 vapier Exp $

inherit enlightenment

DESCRIPTION="nice thumbnail generator"

DEPEND="${DEPEND}
	media-libs/imlib2
	media-libs/epeg
	media-libs/libpng"
