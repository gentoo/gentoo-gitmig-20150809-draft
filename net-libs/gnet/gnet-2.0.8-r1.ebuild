# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnet/gnet-2.0.8-r1.ebuild,v 1.2 2010/01/10 16:36:36 fauli Exp $

EAPI="2"

inherit gnome2 eutils

DESCRIPTION="A simple network library."
HOMEPAGE="http://www.gnetlibrary.org/"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~sparc-solaris ~x86-solaris"

IUSE="doc test"

# FIXME: network-tests & use of valgrind

RDEPEND=">=dev-libs/glib-2.6"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.2 )
	test? ( >=dev-libs/check-0.9.4 )"

DOCS="AUTHORS BUGS ChangeLog HACKING NEWS README* TODO"

src_prepare() {
	gnome2_src_prepare

	# Fix #define location
	epatch "${FILESDIR}/${P}-define-location.patch"
}
