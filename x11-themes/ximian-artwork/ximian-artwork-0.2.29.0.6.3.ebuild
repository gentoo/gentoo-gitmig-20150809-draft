# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/ximian-artwork/ximian-artwork-0.2.29.0.6.3.ebuild,v 1.12 2005/04/07 17:20:37 blubb Exp $

inherit rpm eutils

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
KEYWORDS="x86 sparc amd64 ppc"
IUSE="xmms"

DEPEND="sys-devel/autoconf
	sys-devel/automake
	app-arch/rpm2targz"


RDEPEND=">=x11-themes/gnome-themes-extras-0.5"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	rpm_src_unpack
	epatch ${FILESDIR}/${PN}-${MY_PV}-disable_industrial.patch
}

src_compile() {
	aclocal && autoconf && automake || die
	libtoolize --copy --force
	econf || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	# Removing trademarks
	patch ${D}/usr/share/gdm/themes/industrial/industrial.xml < ${FILESDIR}/${PN}-0.2.26-gdm.patch || die "patch failed"
	rm -f ${D}/usr/share/gdm/themes/industrial/xd2logo.png
	rm -rf ${D}/usr/share/pixmaps/ximian
	rm -f ${D}/usr/share/pixmaps/ximian-desktop-stripe.png

	# Set up X11 implementation
	X11_IMPLEM_P="$(best_version virtual/x11)"
	X11_IMPLEM="${X11_IMPLEM_P%-[0-9]*}"
	X11_IMPLEM="${X11_IMPLEM##*\/}"
	einfo "X11 implementation is ${X11_IMPLEM}."

	# Moving cursors
	dodir /usr/share/cursors/${X11_IMPLEM}/Industrial
	mv ${D}/usr/share/icons/Industrial/cursors ${D}/usr/share/cursors/${X11_IMPLEM}/Industrial

	# remove xmms skin if unneeded
	use xmms || rm -rf ${D}/usr/share/xmms

	cd ${S}
	dodoc COPYING ChangeLog
}
