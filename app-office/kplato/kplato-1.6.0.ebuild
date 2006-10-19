# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kplato/kplato-1.6.0.ebuild,v 1.1 2006/10/19 16:38:06 flameeyes Exp $

KMNAME=koffice
MAXKOFFICEVER=${PV}
inherit kde-meta eutils

DESCRIPTION="KPlato is a project management application."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2 LGPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="$(deprange $PV $MAXKOFFICEVER app-office/koffice-libs)"


DEPEND="${RDEPEND}
	dev-util/pkgconfig"

KMCOPYLIB="libkofficecore lib/kofficecore
	libkofficeui lib/kofficeui
	libkopainter lib/kopainter
	libkstore lib/store"

KMEXTRACTONLY="lib/
	kugar/"

KMCOMPILEONLY=""

KMEXTRA="kdgantt"

need-kde 3.4
