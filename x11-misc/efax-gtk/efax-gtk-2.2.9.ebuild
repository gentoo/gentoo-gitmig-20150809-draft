# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/efax-gtk/efax-gtk-2.2.9.ebuild,v 1.1 2004/11/07 13:26:28 pyrania Exp $

DESCRIPTION="GTK+2 frontend for the efax program."

HOMEPAGE="http://efax-gtk.sourceforge.net/"
SRC_URI="mirror://sourceforge/efax-gtk/${P}.src.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=dev-cpp/gtkmm-2.0.5
		>=x11-libs/gtk+-2*
		>=sys-apps/sed-4"
RDEPEND=">=net-misc/efax-0.9*"


src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i -e 's:efax-0.9a:efax:' src/efax_controller.cpp src/main.cpp
	sed -i -e 's:efix-0.9a:efix:' src/fax_list.cpp
}

src_install() {

	# The binaries
	dobin src/efax-gtk
	# The man page
	doman efax-gtk.1.gz

	# The spool directory and print filter
	dodir /var/spool/fax
	fowners lp:lp /var/spool/fax
	insinto /var/spool/fax
	insopts -m755 -oroot -groot
	doins efax-gtk-faxfilter/efax-gtk-faxfilter

	# Config file
	insinto /etc
	doins efax-gtkrc

	# Docs
	dodoc BUGS COPYRIGHT HISTORY README
}
