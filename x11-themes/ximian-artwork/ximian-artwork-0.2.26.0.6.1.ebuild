# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/ximian-artwork/ximian-artwork-0.2.26.0.6.1.ebuild,v 1.3 2003/06/24 21:49:30 mholzer Exp $

inherit eutils rpm

# bash magic to extract last 2 versions as XIMIAN_V, 
# third last version as RPM_V and the rest as MY_PV
MY_PV=${PV%.[0-9]*.[0-9]*.[0-9]*}
END_V=${PV/${MY_PV}./}
RPM_V=${END_V%.[0-9]*.[0-9]*}
XIMIAN_V=${END_V#[0-9]*.}

DESCRIPTION="Ximian Desktop's GTK, Galeon, GDM, Metacity, Nautilus, XMMS themes, icons and cursors."
HOMEPAGE="http://www.ximian.com/xd2/"
SRC_URI="ftp://ftp.ximian.com/pub/xd2/redhat-9-i386/source/${PN}-${MY_PV}-${RPM_V}.ximian.${XIMIAN_V}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="xmms"

# until we can do mutliple dep on one package, it'll be >=x11-libs/gtk+-1.2
# even though we want =x11-libs/gtk+-1.2 and >=x11-libs/gtk+-2
DEPEND="sys-devel/autoconf
	sys-devel/automake
	app-arch/rpm2targz
	>=media-libs/gdk-pixbuf-0.2.5
	>=x11-libs/gtk+-1.2"

# Because one may only want to use the theme with kde OR gtk OR Metacity
# OR gdm, we don't want any run-time dependencies...
RDEPEND=""

S="${WORKDIR}/${PN}-${MY_PV}"

#src_unpack() {
#	cd ${WORKDIR}
#	rpm2targz ${DISTDIR}/${A}
#	tar xzf ${PN}-${MY_PV}-${RPM_V}.ximian.${XIMIAN_V}.src.tar.gz
#	tar xzf ${PN}-${MY_PV}.tar.gz
#}

src_compile() {
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	# Removing trademarks
	patch ${D}/usr/share/gdm/themes/industrial/industrial.xml < ${FILESDIR}/${PN}-${MY_PV}-gdm.patch || die "patch failed"
	rm -f ${D}/usr/share/gdm/themes/industrial/xd2logo.png
	rm -rf ${D}/usr/share/pixmaps/ximian
	rm -f ${D}/usr/share/pixmaps/ximian-desktop-stripe.png
	
	# Moving cursors
	dodir /usr/share/cursors/xfree/Industrial
	mv ${D}/usr/share/icons/Industrial/cursors ${D}/usr/share/cursors/xfree/Industrial

	# remove xmms skin if unneeded
	[ -n "`use xmms`" ] || rm -rf ${D}/usr/share/xmms
	
	cd ${S}
	dodoc COPYING ChangeLog
}

