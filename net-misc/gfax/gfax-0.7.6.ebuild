# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gfax/gfax-0.7.6.ebuild,v 1.4 2007/10/23 09:21:36 genstef Exp $

inherit gnome2 mono eutils autotools

MY_P="gfax_0.7.6"
DESCRIPTION="Gfax is a free fax front end"
HOMEPAGE="http://gfax.cowlug.org/"
#SRC_URI="http://gfax.cowlug.org/${P}-1.tar.gz"
SRC_URI="mirror://debian/pool/main/g/gfax/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/g/gfax/${MY_P}-2.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-0.93
	>=dev-dotnet/gtk-sharp-2
	>=dev-dotnet/gconf-sharp-2
	>=dev-dotnet/glade-sharp-2
	>=dev-dotnet/gnome-sharp-2
	gnome-base/libgnomeprint
	dev-dotnet/evolution-sharp"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.25"

G2CONF="${G2CONF} --enable-dbus=no"
DOCS="AUTHORS ChangeLog FAQ NEWS README TODO"
USE_DESTDIR="1"

src_unpack() {
	unpack ${A}
	epatch ${MY_P}-2.diff
	cd ${S}
	while read line; do
		epatch debian/patches/"$line".dpatch
	done < debian/patches/00list
	intltoolize --force
	eautoreconf
}

src_compile() {
	addwrite /root/.gconf
	addwrite /root/.gconfd
	gnome2_src_compile
}

src_install() {
	gnome2_src_install

	keepdir /var/spool/gfax/doneq /var/spool/gfax/recq
}
