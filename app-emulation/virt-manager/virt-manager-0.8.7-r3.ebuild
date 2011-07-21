# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/virt-manager/virt-manager-0.8.7-r3.ebuild,v 1.1 2011/07/21 21:39:41 cardoe Exp $

#BACKPORTS=

EAPI=2

PYTHON_DEPEND="2:2.4"

# Stop gnome2.eclass from doing stuff on USE=debug
GCONF_DEBUG="no"

inherit eutils gnome2 python ${HG_ECLASS}

SRC_URI="http://virt-manager.org/download/sources/${PN}/${P}.tar.gz
	${BACKPORTS:+mirror://gentoo/${P}-backports-${BACKPORTS}.tar.bz2}"
KEYWORDS="~amd64"
VIRTINSTDEP=">=app-emulation/virtinst-0.500.6"

DESCRIPTION="A graphical tool for administering virtual machines (KVM/Xen)"
HOMEPAGE="http://virt-manager.org/"
LICENSE="GPL-2"
SLOT="0"
IUSE="gnome-keyring policykit sasl spice"
RDEPEND=">=dev-python/pygtk-1.99.12
	>=app-emulation/libvirt-0.7.0[python,sasl?]
	>=dev-libs/libxml2-2.6.23[python]
	${VIRTINSTDEP}
	>=gnome-base/librsvg-2
	>=x11-libs/vte-0.12.2:0[python]
	>=net-libs/gtk-vnc-0.3.8[python,sasl?]
	>=dev-python/dbus-python-0.61
	>=dev-python/gconf-python-1.99.11
	dev-python/urlgrabber
	gnome-keyring? ( dev-python/gnome-keyring-python )
	policykit? ( sys-auth/polkit )
	spice? ( >=net-misc/spice-gtk-0.6[python,sasl?,-gtk3] )"
DEPEND="${RDEPEND}
	app-text/rarian
	dev-util/intltool"

# The TUI (terminal UI) requires newt_syrup which is not packaged on
# Gentoo. bug #356711
G2CONF="--without-tui"

src_prepare() {
	sed -e "s/python/python2/" -i src/virt-manager.in || \
		die "python2 update failed"

	[[ -n ${BACKPORTS} ]] && \
		EPATCH_FORCE=yes EPATCH_SUFFIX="patch" EPATCH_SOURCE="${S}/patches" \
			epatch

	epatch "${FILESDIR}/${P}-vcpu-stats.patch"

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
