# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: system@gentoo.org
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim/gaim-0.57.ebuild,v 1.2 2002/04/30 11:18:16 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Gtk AOL Instant Messenger client"
SRC_URI="http://prdownloads.sourceforge.net/gaim/${P}.tar.bz2"
HOMEPAGE="http://gaim.sourceforge.net"
SLOT="0"
DEPEND=">=x11-libs/gtk+-1.2.10-r4
	esd? ( >=media-sound/esound-0.2.22-r2 )
	nls? ( sys-devel/gettext )
	nas? ( >=media-libs/nas-1.4.1-r1 )
	arts? ( kde-base/arts )
	perl? ( >=sys-devel/perl-5.6.1 )
	gnome? ( >=gnome-base/gnome-core-1.4
		>=media-libs/gdk-pixbuf-0.16.0 )"
	
src_compile() {
	
	local myopts gnomeopts

	use esd ||  myopts="--disable-esd"
	use nas ||  myopts="${myopts} --disable-nas"
	use perl || myopts="${myopts} --disable-perl"

	use arts || myopts="${myopts} --disable-arts"
	use arts && KDEDIR=/usr/kde/3

	use nls || myopts="${myopts} --disable-nls"

	gnomeopts="${myopts}"
	myopts="${myopts} --disable-gnome"

	# always build standalone gaim program
	econf ${myopts} || die
	emake || die

	# if gnome support is enabled, then build gaim_applet
	use gnome && ( \
		gnomeopts="${gnomeopts} --with-gnome=${GNOME_PATH} --enable-panel"

		# save appletless version and clean up
		cp src/gaim ${S}/gaim
		make distclean || die

		configure ${gnomeopts} || die
		emake || die
	)

}

src_install () {

	einstall || die

	# if gnome enabled, make sure to install standalone version also
	use gnome && dobin ${S}/gaim

	dodoc ChangeLog README README.plugins
}
