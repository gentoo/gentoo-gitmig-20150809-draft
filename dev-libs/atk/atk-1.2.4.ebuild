# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/atk/atk-1.2.4.ebuild,v 1.8 2004/01/09 16:59:23 agriffis Exp $

inherit gnome2

IUSE="doc"
S=${WORKDIR}/${P}
DESCRIPTION="Gnome Accessibility Toolkit"
HOMEPAGE="http://developer.gnome.org/projects/gap/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc alpha sparc hppa amd64"

RDEPEND=">=dev-libs/glib-2"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.9-r2 )
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog COPYING README* INSTALL NEWS"
