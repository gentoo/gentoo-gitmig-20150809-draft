# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome2-user-docs/gnome2-user-docs-2.14.0.ebuild,v 1.3 2006/09/05 03:15:05 kumba Exp $

inherit gnome2

MY_PN="gnome-user-docs"
S=${WORKDIR}/${MY_PN}-${PV}
SRC_URI="mirror://gnome/sources/${MY_PN}/${PVP[0]}.${PVP[1]}/${MY_PN}-${PV}.tar.bz2"

DESCRIPTION="end user documentation"
HOMEPAGE="http://www.gnome.org"

LICENSE="FDL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=app-text/scrollkeeper-0.3.11
	>=app-text/gnome-doc-utils-0.5.6"

DOCS="AUTHORS ChangeLog NEWS README"
