# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ewl/ewl-0.0.3.20040710.ebuild,v 1.1 2004/07/12 12:36:54 vapier Exp $

EHACKAUTOGEN=y
inherit enlightenment flag-o-matic

DESCRIPTION="simple-to-use general purpose widget library"
HOMEPAGE="http://www.enlightenment.org/pages/ewl.html"

DEPEND=">=media-libs/edje-0.5.0.20040501
	>=dev-db/edb-1.0.4.20031013
	>=x11-libs/evas-1.0.0.20040501_pre13
	>=x11-libs/ecore-1.0.0.20040501_pre7
	>=media-libs/etox-0.0.2.20040327"
