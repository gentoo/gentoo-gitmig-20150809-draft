# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# /space/gentoo/cvsroot/gentoo-x86/net-im/gaim/gaim-0.58-r1.ebuild,v 1.2 2002/05/23 06:50:15 seemant Exp

S=${WORKDIR}/${P}
DESCRIPTION="Gtk Instant Messenger client"

SRC_URI1="http://unc.dl.sourceforge.net/sourceforge/gaim/${P}.tar.bz2"
SRC_URI2="http://telia.dl.sourceforge.net/sourceforge/gaim/${P}.tar.bz2"
SRC_URI3="http://belnet.dl.sourceforge.net/sourceforge/gaim/${P}.tar.bz2"
SRC_URI="${SRC_URI1} ${SRC_URI2} ${SRC_URI3}"

HOMEPAGE="http://gaim.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
DEPEND="=x11-libs/gtk+-1.2*
	=sys-libs/db-1*
	esd? ( >=media-sound/esound-0.2.22-r2 )
	nls? ( sys-devel/gettext )
	nas? ( >=media-libs/nas-1.4.1-r1 )
	arts? ( >=kde-base/arts-0.9.5 )
	perl? ( >=sys-devel/perl-5.6.1 )
	gnome? ( >=gnome-base/gnome-core-1.4
		>=media-libs/gdk-pixbuf-0.16.0 )"

RDEPEND="${DEPEND}"

src_compile() {
	
	local myopts gnomeopts

	use esd  || myopts="--disable-esd"
	use nas  || myopts="${myopts} --disable-nas"
	use perl || myopts="${myopts} --disable-perl"

	use arts || myopts="${myopts} --disable-artsc"
	use arts && KDEDIR="${KDE3DIR}"

	use nls  || myopts="${myopts} --disable-nls"

	gnomeopts="${myopts}"
	myopts="${myopts} --disable-gnome"

	# always build standalone gaim program
	
	# transparency
	# patch -p1 < ${FILESDIR}/transparency.diff || die
	econf ${myopts} || die
	emake || die

	# if gnome support is enabled, then build gaim_applet
	use gnome && ( \
		gnomeopts="${gnomeopts} --with-gnome=${GNOME_PATH} --enable-panel"

		# save appletless version and clean up
		cp src/gaim ${S}/gaim || die "standalone version failed to build"
		make distclean || die

		econf ${gnomeopts} || die
		emake || die
	)

}

src_install () {

	make DESTDIR=${D} install || die

	# if gnome enabled, make sure to install standalone version also
	use gnome && dobin ${S}/gaim

	dodoc ABOUT-NLS AUTHORS HACKING INSTALL NEWS README TODO
}
