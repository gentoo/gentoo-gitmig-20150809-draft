# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libcroco/libcroco-0.6.0.ebuild,v 1.13 2006/01/06 11:20:25 flameeyes Exp $

inherit autotools gnome2

DESCRIPTION="Generic Cascading Style Sheet (CSS) parsing and manipulation toolkit"
HOMEPAGE="http://www.freespiders.org/projects/libcroco/"

LICENSE="LGPL-2"
SLOT="0.6"
KEYWORDS="x86 alpha amd64 arm hppa ia64 mips ppc ppc64 sparc"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/libxml2-2.4.23"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-as_needed_ldflags_fix.patch
	eautomake
}
DOCS="AUTHORS ChangeLog HACKING INSTALL NEWS README TODO"
