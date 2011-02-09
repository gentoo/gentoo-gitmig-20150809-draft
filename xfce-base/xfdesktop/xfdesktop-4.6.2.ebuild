# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfdesktop/xfdesktop-4.6.2.ebuild,v 1.15 2011/02/09 21:11:26 ssuominen Exp $

EAPI=3
EAUTORECONF=yes
inherit xfconf

DESCRIPTION="Desktop manager for Xfce4"
HOMEPAGE="http://www.xfce.org/projects/xfdesktop"
SRC_URI="mirror://xfce/src/xfce/${PN}/4.6/${P}.tar.bz2
	branding? ( http://www.gentoo.org/images/backgrounds/gentoo-minimal-1280x1024.jpg )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"
IUSE="+branding debug +xfce_plugins_menu thunar"

LINGUAS="be ca cs da de el es et eu fi fr he hu it ja ko nb_NO nl pa pl pt_BR ro ru sk sv tr uk vi zh_CN zh_TW"

for X in ${LINGUAS}; do
	IUSE="${IUSE} linguas_${X}"
done

RDEPEND="gnome-base/libglade
	x11-libs/libX11
	x11-libs/libSM
	>=x11-libs/libwnck-2.12
	>=dev-libs/glib-2.10:2
	>=x11-libs/gtk+-2.10:2
	>=xfce-base/libxfce4util-4.6
	>=xfce-base/libxfcegui4-4.6
	>=xfce-base/libxfce4menu-4.6
	>=xfce-base/xfconf-4.6
	thunar? (
		|| ( ( =xfce-base/exo-0.3* <xfce-base/thunar-1.1.0 ) xfce-extra/thunar-vfs )
		dev-libs/dbus-glib )
	xfce_plugins_menu? ( >=xfce-base/xfce4-panel-4.6 )"
DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	dev-util/pkgconfig"

pkg_setup() {
	XFCE_LOCALIZED_CONFIGS="/etc/xdg/xfce4/desktop/menu.xml
		/etc/xdg/xfce4/desktop/xfce-registered-categories.xml"

	PATCHES=(
		"${FILESDIR}"/${P}-automagic.patch
		"${FILESDIR}"/${P}-assert.patch
		)

	# For Xfce 4.7/4.8, panel plug-in is elsewhere and too old exo/thunarx required
	local mycfg
	has_version ">=xfce-base/xfce4-panel-4.7" && mycfg="--disable-panel-plugin"
	has_version "xfce-extra/thunar-vfs" && mycfg+=" --disable-exo --disable-thunarx"

	XFCONF="--disable-dependency-tracking
		--disable-static
		$(use_enable thunar file-icons)
		$(use_enable thunar thunarx)
		$(use_enable thunar exo)
		$(use_enable xfce_plugins_menu panel-plugin)
		$(xfconf_use_debug)
		${mycfg}"

	DOCS="AUTHORS ChangeLog NEWS TODO README"
}

src_prepare() {
	if use branding; then
		sed -i \
			-e 's:xfce-stripes.png:gentoo-minimal-1280x1024.jpg:' \
			common/xfdesktop-common.h || die
	fi

	# Outdated files and we install HTML files to $PF
	sed -i \
		-e '/xfce4-help.desktop/d' \
		modules/menu/menu-data/{Makefile.am,xfce-applications.menu} || die

	xfconf_src_prepare
}

src_install() {
	xfconf_src_install

	if use branding; then
		insinto /usr/share/xfce4/backdrops
		doins "${DISTDIR}"/gentoo-minimal-1280x1024.jpg || die
	fi

	local config lang
	for config in ${XFCE_LOCALIZED_CONFIGS}; do
		for lang in ${LINGUAS}; do
			local localized_config="${D}/${config}.${lang}"
			if [[ -f ${localized_config} ]]; then
				use "linguas_${lang}" || rm ${localized_config}
			fi
		done
	done
}
