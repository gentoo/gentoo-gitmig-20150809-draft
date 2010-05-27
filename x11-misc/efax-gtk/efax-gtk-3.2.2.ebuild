# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/efax-gtk/efax-gtk-3.2.2.ebuild,v 1.1 2010/05/27 23:35:29 hwoarang Exp $

DESCRIPTION="GTK+2 frontend for the efax program."
HOMEPAGE="http://efax-gtk.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="nls"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	# The binaries
	dobin src/efax-gtk
	dobin efax/efax-0.9a
	dobin efax/efix-0.9a

	# The man page
	doman efax-gtk.1

	# Native Language Support (NLS)
	if use nls; then
		for gmo in po/*.gmo; do
			cp --force $gmo $(echo $gmo | sed 's:\.g:\.:')
		done
		domo po/*.mo
	fi

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
	dodoc AUTHORS BUGS ChangeLog README
}
