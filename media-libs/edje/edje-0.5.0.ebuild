# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/edje/edje-0.5.0.ebuild,v 1.3 2004/08/30 18:58:47 vapier Exp $

inherit enlightenment

DESCRIPTION="graphical layout and animation library"
HOMEPAGE="http://www.enlightenment.org/pages/edje.html"

KEYWORDS="x86 ppc sparc alpha hppa amd64 ia64"

DEPEND=">=dev-libs/eet-0.9.9
	>=x11-libs/evas-1.0.0_pre13
	>=media-libs/imlib2-1.1.1
	>=x11-libs/ecore-1.0.0_pre7
	>=dev-libs/embryo-0.9.0"
