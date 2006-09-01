# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/linc/linc-1.0.3-r1.ebuild,v 1.4 2006/09/01 02:13:53 dang Exp $

inherit eutils gnome2

DESCRIPTION="A library to ease the writing of networked applications"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ppc ~sparc ~x86"
IUSE="doc ssl"

RDEPEND=">=dev-libs/glib-2
	ssl? ( >=dev-libs/openssl-0.9.6 )"
DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.6 )
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} $(use_with ssl openssl)"

DOCS="AUTHORS ChangeLog HACKING MAINTAINERS README* NEWS TODO"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Avoid docbook conflicts. See bug #46692.
	epatch "${FILESDIR}"/${P}-gtkdoc_fix.patch
	# Fix building with gcc4.
	epatch "${FILESDIR}"/${P}-gcc4.patch
	# Make sure we quote enough
	epatch "${FILESDIR}"/${P}-m4.patch
}
