# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/etox/etox-0.9.0.20040529.ebuild,v 1.2 2004/06/24 22:59:16 agriffis Exp $

EHACKAUTOGEN=yes
export WANT_AUTOMAKE=1.8
inherit enlightenment

DESCRIPTION="type setting and text layout library"
HOMEPAGE="http://www.enlightenment.org/pages/etox.html"

DEPEND=">=x11-libs/evas-1.0.0.20031020_pre12
	>=x11-libs/ecore-1.0.0.20031013_pre4
	>=dev-db/edb-1.0.4.20031013"
