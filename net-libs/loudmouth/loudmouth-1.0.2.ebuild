# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/loudmouth/loudmouth-1.0.2.ebuild,v 1.1 2006/04/05 13:27:39 foser Exp $

inherit gnome2 eutils

DESCRIPTION="Lightweight C Jabber library"
HOMEPAGE="http://loudmouth.imendio.org/"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="doc ssl debug"

RDEPEND=">=dev-libs/glib-2.4
	ssl? ( >=net-libs/gnutls-1 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README"

pkg_setup() {

	G2CONF="$(use_with ssl) \
		$(use_enable debug)\
		$(use_enable doc gtk-doc)"

}

src_unpack() {

	unpack ${A}

	cd ${S}/loudmouth
	# fix building sans ssl
	epatch ${FILESDIR}/${P}-build_without_ssl.patch

}
