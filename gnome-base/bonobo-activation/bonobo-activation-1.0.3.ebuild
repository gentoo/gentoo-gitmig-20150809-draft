# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/bonobo-activation/bonobo-activation-1.0.3.ebuild,v 1.11 2003/09/06 23:51:37 msterret Exp $

IUSE="doc"

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="Gnome2 replacement for OAF"
SRC_URI="mirror://gnome/2.0.0/sources/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

RDEPEND=">=dev-libs/glib-2.0.4
	>=dev-libs/libxml2-2.4.20
	>=dev-libs/popt-1.6.3
	>=gnome-base/ORBit2-2.4.0
	>=net-libs/linc-0.5.1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9-r2
		>=app-text/openjade-1.3 )"

LIBTOOL_FIX="1"

DOCS="AUTHORS  ABOUT-NLS COPYING* ChangeLog  README* INSTALL NEWS TODO docs/* api-docs/*"


