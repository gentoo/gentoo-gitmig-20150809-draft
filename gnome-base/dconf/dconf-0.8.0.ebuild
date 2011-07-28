# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/dconf/dconf-0.8.0.ebuild,v 1.2 2011/07/28 10:59:12 pacho Exp $

EAPI="4"
GCONF_DEBUG="no"

inherit autotools eutils gnome2 bash-completion

DESCRIPTION="Simple low-level configuration system"
HOMEPAGE="http://live.gnome.org/dconf"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86"
IUSE="doc vala +X"

RDEPEND=">=dev-libs/glib-2.27.3:2
	sys-apps/dbus
	X? ( >=dev-libs/libxml2-2.7.7
		x11-libs/gtk+:3 )"
DEPEND="${RDEPEND}
	doc? ( >=dev-util/gtk-doc-1.15 )
	vala? ( >=dev-lang/vala-0.11.7:0.12 )"

pkg_setup() {
	G2CONF="${G2CONF}
		$(use_enable vala)
		$(use_enable X editor)
		VALAC=$(type -p valac-0.12)"
}

src_prepare() {
	gnome2_src_prepare

	# Fix vala automagic support, upstream bug #634171
	epatch "${FILESDIR}/${PN}-0.8.0-automagic-vala.patch"

	mkdir -p m4 || die
	eautoreconf
}

src_install() {
	gnome2_src_install

	# GSettings backend may be one of: memory, gconf, dconf
	# Only dconf is really considered functional by upstream
	# must have it enabled over gconf if both are installed
	echo 'CONFIG_PROTECT_MASK="/etc/dconf"' >> 51dconf
	echo 'GSETTINGS_BACKEND="dconf"' >> 51dconf
	doenvd 51dconf

	# Remove bash-completion file installed by build system
	rm -rv "${ED}/etc/bash_completion.d/" || die
	use bash-completion && \
		dobashcompletion "${S}/bin/dconf-bash-completion.sh" ${PN}
}

pkg_postinst() {
	gnome2_pkg_postinst
	use bash-completion && bash-completion_pkg_postinst
}
