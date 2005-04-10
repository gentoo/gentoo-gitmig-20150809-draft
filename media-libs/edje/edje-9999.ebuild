# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/edje/edje-9999.ebuild,v 1.5 2005/04/10 03:31:06 vapier Exp $

EHACKAUTOGEN=yes
inherit enlightenment

DESCRIPTION="graphical layout and animation library"
HOMEPAGE="http://www.enlightenment.org/pages/edje.html"

DEPEND=">=dev-libs/eet-0.9.9
	>=x11-libs/evas-0.9.9
	>=media-libs/imlib2-1.2.0
	>=x11-libs/ecore-0.9.9
	>=dev-libs/embryo-0.9.1"
