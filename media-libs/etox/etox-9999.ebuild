# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/etox/etox-9999.ebuild,v 1.1 2004/10/21 20:20:00 vapier Exp $

EHACKAUTOGEN=yes
EAUTOMAKE=1.8
inherit enlightenment

DESCRIPTION="type setting and text layout library"
HOMEPAGE="http://www.enlightenment.org/pages/etox.html"

DEPEND=">=x11-libs/evas-1.0.0_pre13
	>=x11-libs/ecore-1.0.0_pre7
	>=dev-db/edb-1.0.5"
