# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/epsilon/epsilon-0.3.0.20050220.ebuild,v 1.1 2005/02/21 10:05:45 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="nice thumbnail generator"

DEPEND=">=media-libs/imlib2-1.1.2.20041016
	>=media-libs/epeg-0.9.0.20041016
	media-libs/libpng"
