# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/edje/edje-0.5.0.20050116.ebuild,v 1.1 2005/01/17 03:16:19 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="graphical layout and animation library"
HOMEPAGE="http://www.enlightenment.org/pages/edje.html"

DEPEND=">=dev-libs/eet-0.9.9.20041031
	>=x11-libs/evas-1.0.0.20041226_pre13
	>=media-libs/imlib2-1.1.2.20041031
	>=x11-libs/ecore-1.0.0.20041226_pre7
	>=dev-libs/embryo-0.9.1.20041031"
