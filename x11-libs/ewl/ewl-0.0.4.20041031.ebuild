# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/ewl/ewl-0.0.4.20041031.ebuild,v 1.2 2004/11/02 04:39:51 vapier Exp $

EHACKAUTOGEN=y
inherit enlightenment flag-o-matic

DESCRIPTION="simple-to-use general purpose widget library"
HOMEPAGE="http://www.enlightenment.org/pages/ewl.html"

DEPEND=">=media-libs/edje-0.5.0.20041031
	>=dev-db/edb-1.0.5.20041031
	>=x11-libs/evas-1.0.0.20041031_pre13
	>=x11-libs/ecore-1.0.0.20041031_pre7
	>=media-libs/etox-0.9.0.20041031"
