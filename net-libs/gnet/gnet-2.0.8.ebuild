# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnet/gnet-2.0.8.ebuild,v 1.8 2010/11/16 20:54:50 eva Exp $

inherit gnome2 eutils

DESCRIPTION="A simple network library."
HOMEPAGE="http://live.gnome.org/GNetLibrary"

LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"

IUSE="doc test"

# FIXME: network-tests & use of valgrind

RDEPEND=">=dev-libs/glib-2.6"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.2 )
	test? ( >=dev-libs/check-0.9.4 )"

DOCS="AUTHORS BUGS ChangeLog HACKING NEWS README* TODO"
