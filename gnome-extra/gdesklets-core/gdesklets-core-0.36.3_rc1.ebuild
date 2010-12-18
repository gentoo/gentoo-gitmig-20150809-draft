# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gdesklets-core/gdesklets-core-0.36.3_rc1.ebuild,v 1.1 2010/12/18 21:18:09 nixphoeni Exp $

EAPI=2
# desklets don't run with USE=debug
GCONF_DEBUG="no"
PYTHON_DEPEND="2:2.4"

inherit gnome2 python eutils autotools multilib bash-completion

MY_PN="${PN/-core}"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="GNOME Desktop Applets: Core library for desktop applets"
SRC_URI="http://gdesklets.de/files/${MY_P}.tar.bz2"
HOMEPAGE="http://www.gdesklets.de"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

# is libgsf needed for runtime or just compiling?
RDEPEND=">=dev-libs/glib-2.4
	gnome-extra/libgsf
	>=gnome-base/librsvg-2.8
	>=gnome-base/libgtop-2.8.2
	>=dev-python/pygtk-2.10
	>=dev-python/gnome-python-2.6
	>=dev-libs/expat-1.95.8
	>=dev-python/pyxml-0.8.3-r1"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README TODO"
CONVERT_SHEBANGS="ctrlinfo gdesklets gdesklets-daemon gdesklets-logview \
	gdesklets-shell test-control.py contrib/gdesklets-migration-tool"

pkg_setup() {

	python_set_active_version 2

}

src_prepare() {

	gnome2_src_prepare

	# Postpone pyc compiling until pkg_postinst
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile

	eautoreconf
	intltoolize --force || die

	python_convert_shebangs 2 ${CONVERT_SHEBANGS}

}

src_install() {

	gnome2_src_install

	# Install bash completion script
	BASHCOMPLETION_NAME="gDesklets" \
		dobashcompletion "contrib/bash/gdesklets"

	# Install the gdesklets-control-getid script
	insinto "/usr/$(get_libdir)/gdesklets"
	insopts -m0555
	doins "${FILESDIR}/gdesklets-control-getid"

	# Ensure the global Displays and Controls directories exist
	dodir "/usr/$(get_libdir)/gdesklets/Displays"
	dodir "/usr/$(get_libdir)/gdesklets/Controls"

}

pkg_postinst() {

	gnome2_pkg_postinst
	python_need_rebuild
	# Compile pyc files on target system
	python_mod_optimize "/usr/$(get_libdir)/gdesklets"

	echo
	elog "gDesklets Displays are required before the library"
	elog "will be usable.  Core Displays (Calendar, Clock, Quote-of-the-Day,"
	elog "and the 15pieces game) are already installed in"
	elog "           ${ROOT}usr/$(get_libdir)/gdesklets/Displays"
	elog "Additional Displays can be found in -"
	elog "           x11-plugins/desklet-* ,"
	elog "at http://www.gdesklets.de, or at http://archive.gdesklets.info"
	elog
	elog "Next you'll need to start gDesklets using"
	elog "           ${ROOT}usr/bin/gdesklets start"
	elog "If you're using GNOME this can be done conveniently through"
	elog "Applications->Accessories->gDesklets or automatically each login"
	elog "under System->Preferences->Sessions"
	elog
	elog "If you're updating from a version less than 0.35_rc1,"
	elog "you can migrate your desklet configurations by"
	elog "running"
	elog "           ${ROOT}usr/$(get_libdir)/gdesklets/contrib/gdesklets-migration-tool"
	elog "after the first time you run gDesklets"
	elog

	BASHCOMPLETION_NAME="gDesklets" bash-completion_pkg_postinst

}

pkg_postrm() {

	gnome2_pkg_postrm
	# Cleanup after our cavalier python compilation
	# The function takes care of ${ROOT} for us
	python_mod_cleanup "/usr/$(get_libdir)/gdesklets"

}
