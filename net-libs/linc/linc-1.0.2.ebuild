# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/linc/linc-1.0.2.ebuild,v 1.1 2003/05/20 12:05:42 foser Exp $

IUSE="doc ssl"

inherit libtool gnome2

S=${WORKDIR}/${P}
DESCRIPTION="A library to ease the writing of networked applications"
HOMEPAGE="http://www.gnome.org/"

SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"

RDEPEND=">=dev-libs/glib-2
	ssl? ( >=dev-libs/openssl-0.9.6 )"

DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-0.6 )
	>=dev-util/pkgconfig-0.12.0"

G2CONF="${G2CONF} $(use_with ssl openssl)"	  

DOCS="AUTHORS ChangeLog COPYING HACKING MAINTAINERS README* NEWS TODO"

