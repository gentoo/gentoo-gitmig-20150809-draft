# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/epsilon/epsilon-0.0.2.20040522.ebuild,v 1.2 2004/06/24 22:58:54 agriffis Exp $

inherit enlightenment

DESCRIPTION="nice thumbnail generator"

DEPEND="${DEPEND}
	media-libs/imlib2
	media-libs/epeg
	media-libs/libpng"
