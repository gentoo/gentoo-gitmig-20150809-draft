# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/efax-gtk/efax-gtk-2.0.7.ebuild,v 1.1 2003/05/26 01:37:48 avenj Exp $

DESCRIPTION="GTK+2 frontend for the efax program."

HOMEPAGE="http://www.cvine.freeserve.co.uk/efax-gtk"
SRC_URI="http://www.cvine.freeserve.co.uk/efax-gtk/${P}.src.tgz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND=">=x11-libs/gtkmm-2.0.5
	>=x11-libs/gtk+-2*"
RDEPEND=">=net-misc/efax-0.9*"


S=${WORKDIR}/${PN}

src_compile() {
	econf
	emake || die
}

src_install() {
	
	# The binaries
	dobin efax-gtk efax-gtk-send

	# The man page
	doman efax-gtk.1.gz
	
	# The spool directory and print filter
	dodir /var/spool/fax
	fowners lp:lp /var/spool/fax
	insinto /var/spool/fax
	insopts -m755 -oroot -groot
	doins efax-gtk-faxfilter
	
	# Config file
	insinto /etc
	doins efax-gtkrc
	
	# Docs
	dodoc BUGS COPYRIGHT HISTORY README 
}
