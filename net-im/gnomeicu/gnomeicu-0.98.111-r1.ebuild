# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gnomeicu/gnomeicu-0.98.111-r1.ebuild,v 1.5 2003/05/09 22:47:57 liquidx Exp $


inherit debug

S=${WORKDIR}/${P}
DESCRIPTION="Gnome ICQ Client"
SRC_URI="mirror://sourceforge/gnomeicu/${P}.tar.bz2"
HOMEPAGE="http://gnomeicu.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

DEPEND=">=x11-libs/gtk+-2.0.5
	>=dev-libs/libxml2-2.4.23
	>=gnome-base/libgnome-2.0.0
	>=gnome-base/libgnomeui-2.0.0
	>=sys-libs/gdbm-1.8.0
	>=gnome-base/libglade-2.0.0	
	<net-libs/gnet-2
	>=gnome-base/gnome-panel-2.0.0"
RDEPEND="sys-devel/gettext"


src_compile() {                           
	local myconf

	myconf="--prefix=/usr --with-debug"
## with statusmenu is deprecated according to <olivier.crete@tester.ca> (GnomeICU go-maintainer)


##	use gnome && myconf="${myconf} --with-statusmenu"
	econf \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} \
	     sysconfdir=${D}/etc \
	     localstatedir=${D}/var/log	\
	     install || die

	dodoc AUTHORS COPYING CREDITS ChangeLog NEWS README TODO ABOUT-NLS
}
