# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/etox/etox-0.0.2.20040201.ebuild,v 1.1 2004/02/01 20:35:48 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="type setting and text layout library"
HOMEPAGE="http://www.enlightenment.org/pages/etox.html"

DEPEND=">=x11-libs/evas-1.0.0.20031020_pre12
	>=x11-libs/ecore-1.0.0.20031013_pre4
	>=dev-db/edb-1.0.4.20031013
	>=media-libs/ebits-1.0.1.20031013
	>=media-libs/estyle-0.0.2.20031013
	>=dev-libs/ewd-0.0.1.20031013"
