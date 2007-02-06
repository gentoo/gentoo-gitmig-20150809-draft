# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/ximian-artwork/ximian-artwork-0.2.32.1.ebuild,v 1.7 2007/02/06 14:18:19 blubb Exp $

WANT_AUTOMAKE="latest"
WANT_AUTOCONF="latest"

inherit rpm eutils versionator autotools

# bash magic to extract last 2 versions as XIMIAN_V,
# third last version as RPM_V and the rest as MY_PV
MY_PV=$(get_version_component_range 1-3)
RPM_V=$(get_version_component_range 4)

DESCRIPTION="Ximian Desktop's GTK, Galeon, GDM, Metacity, Nautilus, icons and cursors."
HOMEPAGE="http://www.novell.com/products/desktop/"
SRC_URI="http://apt.sw.be/packages/ximian-artwork/ximian-artwork-${MY_PV}-${RPM_V}.rf.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc ~x86"
IUSE=""

DEPEND="app-arch/rpm2targz
	dev-util/intltool"

RDEPEND=">=x11-themes/gnome-themes-extras-0.5"

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	rpm_src_unpack
	cd "${S}"
	epatch "${FILESDIR}/${P}-disable_industrial_engine.patch"

	eautoreconf
}

src_install () {
	emake DESTDIR="${D}" install || die "emake install failed"

	# Removing trademarks
	patch "${D}"/usr/share/gdm/themes/industrial/industrial.xml < ${FILESDIR}/${PN}-0.2.26-gdm.patch || die "patch failed"
	rm -f "${D}"/usr/share/gdm/themes/industrial/xd2logo.png
	rm -rf "${D}"/usr/share/pixmaps/ximian
	rm -f "${D}"/usr/share/pixmaps/ximian-desktop-stripe.png

	# Set up X11 implementation
	X11_IMPLEM="xorg-x11"
	dodir /usr/share/cursors/${X11_IMPLEM}/Industrial
	mv "${D}"/usr/share/icons/Industrial/cursors "${D}"/usr/share/cursors/${X11_IMPLEM}/Industrial

	# remove xmms skin if unneeded
	rm -rf "${D}"/usr/share/xmms

	# remove colliding files, see bug 150272
	DUPES="/usr/share/icons/gnome/32x32/apps/file-manager.png
		/usr/share/icons/gnome/32x32/apps/logviewer.png
		/usr/share/icons/gnome/48x48/apps/administration.png
		/usr/share/icons/gnome/48x48/apps/apacheconf.png
		/usr/share/icons/gnome/48x48/apps/applets-screenshooter.png
		/usr/share/icons/gnome/48x48/apps/gnome-networktool.png
		/usr/share/icons/gnome/48x48/apps/network-config.png
		/usr/share/icons/gnome/48x48/apps/postscript-viewer.png
		/usr/share/icons/gnome/48x48/apps/serviceconf.png"
	for i in $DUPES; do
		rm -f "${D}/${i}"
	done

	cd "${S}"
	dodoc ChangeLog
}
