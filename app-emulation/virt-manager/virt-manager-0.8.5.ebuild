# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virt-manager/virt-manager-0.8.5.ebuild,v 1.2 2010/09/03 22:03:40 cardoe Exp $

BACKPORTS=1

EAPI=2

PYTHON_DEPEND="2:2.4"

# Stop gnome2.eclass from doing stuff on USE=debug
GCONF_DEBUG="no"

inherit eutils gnome2 python

DESCRIPTION="A graphical tool for administering virtual machines (KVM/Xen)"
HOMEPAGE="http://virt-manager.org/"
SRC_URI="http://virt-manager.org/download/sources/${PN}/${P}.tar.gz
	${BACKPORTS:+mirror://gentoo/${P}-backports-${BACKPORTS}.tar.bz2}"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome-keyring policykit sasl"
RDEPEND=">=dev-python/pygtk-1.99.12
	>=app-emulation/libvirt-0.7.0[python,sasl?]
	>=dev-libs/libxml2-2.6.23[python]
	>=app-emulation/virtinst-0.500.4
	>=gnome-base/librsvg-2
	>=x11-libs/vte-0.12.2[python]
	>=net-libs/gtk-vnc-0.3.8[python,sasl?]
	>=dev-python/dbus-python-0.61
	>=dev-python/gconf-python-1.99.11
	dev-python/urlgrabber
	gnome-keyring? ( dev-python/gnome-keyring-python )
	policykit? ( gnome-extra/polkit-gnome )"
DEPEND="${RDEPEND}
	app-text/rarian"

src_prepare() {
	sed -e "s/python/python2/" -i src/virt-manager.in || \
		die "python2 update failed"

	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch

	gnome2_src_prepare
}

src_install() {
	gnome2_src_install

	insinto /usr/share/virt-manager/pixmaps/
	doins "${S}"/pixmaps/*.png
	doins "${S}"/pixmaps/*.svg

	insinto /usr/share/virt-manager/pixmaps/hicolor/16x16/actions/
	doins "${S}"/pixmaps/hicolor/16x16/actions/*.png

	insinto /usr/share/virt-manager/pixmaps/hicolor/22x22/actions/
	doins "${S}"/pixmaps/hicolor/22x22/actions/*.png

	insinto /usr/share/virt-manager/pixmaps/hicolor/24x24/actions/
	doins "${S}"/pixmaps/hicolor/24x24/actions/*.png

	insinto /usr/share/virt-manager/pixmaps/hicolor/32x32/actions/
	doins "${S}"/pixmaps/hicolor/32x32/actions/*.png
}
