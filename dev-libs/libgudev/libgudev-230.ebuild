# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgudev/libgudev-230.ebuild,v 1.1 2015/06/10 02:05:48 floppym Exp $

EAPI=5

inherit gnome2 multilib-minimal

DESCRIPTION="GObject bindings for libudev"
HOMEPAGE="https://wiki.gnome.org/Projects/libgudev"
SRC_URI="https://download.gnome.org/sources/libgudev/${PV}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0/0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc introspection"

DEPEND=">=dev-libs/glib-2.22.0:2=
	virtual/libudev:="
RDEPEND="${DEPEND}"

multilib_src_configure() {
	ECONF_SOURCE=${S} gnome2_src_configure $(use_enable introspection)
}

multilib_src_install() {
	gnome2_src_install
}
