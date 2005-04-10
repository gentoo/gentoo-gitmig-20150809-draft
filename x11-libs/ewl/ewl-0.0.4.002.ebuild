# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ewl/ewl-0.0.4.002.ebuild,v 1.1 2005/04/10 03:31:29 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="simple-to-use general purpose widget library"
HOMEPAGE="http://www.enlightenment.org/pages/ewl.html"

DEPEND=">=media-libs/edje-0.5.0
	>=dev-db/edb-1.0.5
	>=x11-libs/evas-0.9.9
	>=x11-libs/ecore-0.9.9
	>=media-libs/etox-0.9.0"
