# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/epsilon/epsilon-0.3.0.20041226.ebuild,v 1.2 2004/12/27 14:40:03 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="nice thumbnail generator"

DEPEND=">=media-libs/imlib2-1.1.2.20041031
	>=media-libs/epeg-0.9.0.20041031
	media-libs/libpng"
