# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome2-user-docs/gnome2-user-docs-2.8.0.1.ebuild,v 1.3 2004/11/12 03:13:18 gustavoz Exp $

inherit gnome2

# stuff needed because of the awkward 2.8.0-1 versioning
MY_PV=2.8.0-1
MY_P=${PN}-${MY_PV}
PVP=(${PV//[-\._]/ })
SRC_URI="mirror://gnome/sources/${PN}/${PVP[0]}.${PVP[1]}/${MY_P}.tar.bz2"
S=${WORKDIR}/${MY_P}

DESCRIPTION="end user documentation"
HOMEPAGE="http://www.gnome.org"
LICENSE="FDL-1.1"

SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha ~hppa ~amd64 ~ia64 ~mips"
IUSE=""

DEPEND=">=app-text/scrollkeeper-0.3.11"

DOCS="AUTHORS COPYING* ChangeLog INSTALL NEWS README"
