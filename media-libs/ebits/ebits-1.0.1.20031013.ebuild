# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/ebits/ebits-1.0.1.20031013.ebuild,v 1.3 2004/03/19 07:56:03 mr_bones_ Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="provides layout functionality for graphical elements like window borders"
HOMEPAGE="http://www.enlightenment.org/pages/ebits.html"

DEPEND="${DEPEND}
	>=x11-libs/evas-1.0.0.20031013_pre12"
