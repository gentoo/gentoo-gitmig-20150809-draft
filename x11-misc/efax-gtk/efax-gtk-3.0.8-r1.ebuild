# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/efax-gtk/efax-gtk-3.0.8-r1.ebuild,v 1.1 2006/03/18 17:04:12 nelchael Exp $

DESCRIPTION="GTK+2 frontend for the efax program."

HOMEPAGE="http://efax-gtk.sourceforge.net/"
SRC_URI="mirror://sourceforge/efax-gtk/${P}.src.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=">=x11-libs/gtk+-2
		>=dev-libs/glib-2
		>=dev-libs/libsigc++-2
		>=sys-apps/sed-4"

src_install() {

	# The binaries
	dobin src/efax-gtk
	dobin efax/efax-0.9a
	dobin efax/efix-0.9a

	# The man page
	doman efax-gtk.1.gz

	# The spool directory and print filter
	dodir /var/spool/fax
	fowners lp:lp /var/spool/fax
	insinto /var/spool/fax
	insopts -m755 -oroot -groot
	doins efax-gtk-faxfilter/efax-gtk-faxfilter
	doins efax-gtk-faxfilter/efax-gtk-socket-client

	# Config file
	insinto /etc
	doins efax-gtkrc

	# Docs
	dodoc BUGS COPYRIGHT HISTORY README
}
