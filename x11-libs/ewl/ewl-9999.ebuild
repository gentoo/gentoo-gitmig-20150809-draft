# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ewl/ewl-9999.ebuild,v 1.1 2004/10/21 20:14:46 vapier Exp $

EHACKAUTOGEN=y
inherit enlightenment flag-o-matic

DESCRIPTION="simple-to-use general purpose widget library"
HOMEPAGE="http://www.enlightenment.org/pages/ewl.html"

DEPEND=">=media-libs/edje-0.5.0.20041016
	>=dev-db/edb-1.0.5.20041016
	>=x11-libs/evas-1.0.0.20041016_pre13
	>=x11-libs/ecore-1.0.0.20041016_pre7
	>=media-libs/etox-0.9.0.20041016"
