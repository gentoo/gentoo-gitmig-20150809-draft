# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/contacts/contacts-0.7.ebuild,v 1.1 2007/08/15 13:08:47 dertobi123 Exp $

inherit gnome2 eutils

DESCRIPTION="A small, lightweight addressbook for GNOME"
HOMEPAGE="http://pimlico-project.org/contacts.html"
SRC_URI="http://pimlico-project.org/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=gnome-extra/evolution-data-server-1.8
		>=x11-libs/gtk+-2.6"

DEPEND="${RDEPEND}
		sys-devel/gettext
		>=dev-util/intltool-0.35.0
		>=dev-util/pkgconfig-0.9
		dev-perl/XML-Parser"

src_unpack() {
	gnome2_src_unpack
	epatch ${FILESDIR}/${PN}-0.5-po.patch
}
