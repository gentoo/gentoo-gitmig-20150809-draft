# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/estyle/estyle-0.0.2.20040327.ebuild,v 1.1 2004/03/31 01:14:17 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="simple API for adding text to an evas with a stylized effect"
HOMEPAGE="http://www.enlightenment.org/pages/estyle.html"

DEPEND=">=media-libs/ebits-1.0.1.20031013
	>=dev-db/edb-1.0.4.20031013
	>=x11-libs/ecore-1.0.0.20031013_pre4
	>=x11-libs/evas-1.0.0.20031020_pre12
	>=dev-libs/ewd-0.0.1.20031013
	>=media-libs/imlib2-1.1.0"
