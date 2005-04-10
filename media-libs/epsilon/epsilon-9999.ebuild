# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/epsilon/epsilon-9999.ebuild,v 1.4 2005/04/10 03:38:37 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="nice thumbnail generator"

DEPEND=">=media-libs/imlib2-1.2.0
	>=media-libs/epeg-0.9.0
	media-libs/libpng"
