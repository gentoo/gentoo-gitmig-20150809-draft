# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcroco/libcroco-0.5.0.ebuild,v 1.10 2004/06/24 23:14:57 agriffis Exp $

inherit gnome2

DESCRIPTION="Generic Cascading Style Sheet (CSS) parsing and manipulation toolkit"
HOMEPAGE="http://www.freespiders.org/projects/libcroco/"

LICENSE="LGPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha hppa ~ia64 amd64 ~mips"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/libxml2-2.4.23"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog HACKING INSTALL NEWS README TODO"
