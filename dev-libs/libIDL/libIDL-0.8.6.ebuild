# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libIDL/libIDL-0.8.6.ebuild,v 1.14 2007/07/12 02:25:34 mr_bones_ Exp $

inherit eutils gnome2

DESCRIPTION="CORBA tree builder"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86 ~x86-fbsd"
IUSE="static"

RDEPEND=">=dev-libs/glib-1.3.7"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison
	dev-util/pkgconfig"

DOCS="AUTHORS BUGS ChangeLog HACKING MAINTAINERS NEWS README"

pkg_setup() {
	G2CONF="$(use_enable static)"
}

src_unpack() {
	unpack ${A}
	epunt_cxx
}
