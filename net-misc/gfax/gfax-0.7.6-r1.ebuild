# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gfax/gfax-0.7.6-r1.ebuild,v 1.1 2008/11/23 14:22:14 loki_val Exp $

EAPI=2

inherit gnome2 mono eutils autotools

MY_P="gfax_0.7.6"
DESCRIPTION="Gfax is a free fax front end"
HOMEPAGE="http://gfax.cowlug.org/"
#SRC_URI="http://gfax.cowlug.org/${P}-1.tar.gz"
SRC_URI="mirror://debian/pool/main/g/gfax/${MY_P}.orig.tar.gz
	mirror://debian/pool/main/g/gfax/${MY_P}-9.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-0.93
	>=dev-dotnet/gtk-sharp-2
	>=dev-dotnet/gconf-sharp-2
	|| ( dev-dotnet/gtk-sharp[glade] >=dev-dotnet/glade-sharp-2 )
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
	epatch ${MY_P}-9.diff
	cd "${S}"
	while read line; do
		if [[ "${line:0:2}" != "03" && "${line:0:2}" != "99" ]]
		then
			epatch debian/patches/"$line".dpatch
		fi
	done < debian/patches/00list
	intltoolize --force || die
	eautoreconf
}

src_configure() {
	addwrite /root/.gconf
	addwrite /root/.gconfd
	gnome2_src_configure
}

src_compile() {
	emake ||die "emake failed"
}

src_install() {
	gnome2_src_install

	keepdir /var/spool/gfax/doneq /var/spool/gfax/recq
}
