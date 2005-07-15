# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/gfax/gfax-0.7.2.ebuild,v 1.3 2005/07/15 01:16:00 agriffis Exp $

inherit gnome2 mono

DESCRIPTION="Gfax is a free fax front end"
HOMEPAGE="http://gfax.cowlug.org/"
SRC_URI="http://gfax.cowlug.org/${P}-2.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-0.93
	=dev-dotnet/gtk-sharp-1.0*
	=dev-dotnet/gconf-sharp-1.0*
	=dev-dotnet/glade-sharp-1.0*
	=dev-dotnet/gnome-sharp-1.0*"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.25"

S=${WORKDIR}/${PN}

G2CONF="${G2CONF} --disable-dbus"
DOCS="AUTHORS ChangeLog FAQ NEWS README TODO"
USE_DESTDIR="1"

src_install() {
	gnome2_src_install eprefix=${D}
	keepdir /var/spool/gfax/doneq /var/spool/gfax/recq
}

pkg_postinst() {
	gnome2_pkg_postinst
	einfo "Please run"
	echo 'env GCONF_CONFIG_SOURCE="" gconftool-2 --makefile-install-rule /etc/gconf/schemas/gfax.schemas'
	einfo "as your local user, to get gfax working"
}
