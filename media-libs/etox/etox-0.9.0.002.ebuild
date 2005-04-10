# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/etox/etox-0.9.0.002.ebuild,v 1.1 2005/04/10 03:28:57 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="type setting and text layout library"
HOMEPAGE="http://www.enlightenment.org/pages/etox.html"

DEPEND=">=x11-libs/evas-0.9.9
	>=x11-libs/ecore-0.9.9
	>=dev-db/edb-1.0.5"
