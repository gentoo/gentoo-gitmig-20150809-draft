# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/linc/linc-1.0.3.ebuild,v 1.8 2004/04/06 04:15:35 leonardop Exp $

IUSE="doc ssl"

inherit eutils gnome2

S=${WORKDIR}/${P}
DESCRIPTION="A library to ease the writing of networked applications"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="x86 ppc sparc ~alpha hppa amd64"

RDEPEND=">=dev-libs/glib-2
	ssl? ( >=dev-libs/openssl-0.9.6 )"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.6 )
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} $(use_with ssl openssl)"

DOCS="AUTHORS ChangeLog COPYING HACKING MAINTAINERS README* NEWS TODO"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Avoid docbook conflicts. See bug #46692.
	epatch ${FILESDIR}/${P}-gtkdoc_fix.patch
}
