# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gdesklets-core/gdesklets-core-0.36-r1.ebuild,v 1.10 2009/04/20 19:41:55 nixphoeni Exp $

# desklets don't run with USE=debug
GCONF_DEBUG="no"

# We want the latest autoconf and automake (the default)
inherit gnome2 python eutils autotools multilib

MY_PN="gdesklets"
MY_P="${MY_PN}-${PV/_/}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="GNOME Desktop Applets: Core library for desktop applets"
SRC_URI="http://gdesklets.de/files/${MY_P}.tar.bz2"
HOMEPAGE="http://www.gdesklets.de"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="alpha amd64 ia64 ppc ~ppc64 ~sparc x86"

# is libgsf needed for runtime or just compiling?
RDEPEND="<dev-lang/python-2.6
	>=dev-libs/glib-2.4
	gnome-extra/libgsf
	>=gnome-base/librsvg-2.8
	>=gnome-base/libgtop-2.8.2
	>=dev-python/pygtk-2.10
	>=dev-python/gnome-python-2.6
	>=dev-libs/expat-1.95.8
	>=dev-python/pyxml-0.8.3-r1
	!x11-plugins/desklet-calendar
	!x11-plugins/desklet-clock"

DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/pkgconfig
	dev-util/intltool"

# Parallel makes sometimes break during install phase
MAKEOPTS="${MAKEOPTS} -j1"
# Force using MAKEOPTS with emake
USE_EINSTALL="0"
DOCS="AUTHORS ChangeLog NEWS README TODO"

src_unpack() {

	gnome2_src_unpack

	# Postpone pyc compiling until pkg_postinst
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile

	# Use po/LINGUAS - see gnome bug #506828
	epatch "${FILESDIR}/${PN}-0.36_beta-linguas.patch"

	eautoreconf
	intltoolize --force || die

}

src_install() {

	gnome2_src_install

	# Install the gdesklets-control-getid script
	insinto /usr/$(get_libdir)/gdesklets
	insopts -m0555
	doins "${FILESDIR}/gdesklets-control-getid"

	# Remove conflicts with x11-misc/shared-mime-info and auto-generated
	# MIME info
	rm -rf 	"${D}/usr/share/mime"

}

pkg_postinst() {

	gnome2_pkg_postinst

	# Compile pyc files on target system
	python_mod_optimize "${ROOT}"/usr/$(get_libdir)/gdesklets

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
	elog "Applications->Accessories->gDesklets"
	elog
	elog "If you're updating from a version less than 0.35_rc1,"
	elog "you can migrate your desklet configurations by"
	elog "running"
	elog "           ${ROOT}usr/$(get_libdir)/gdesklets/gdesklets-migration-tool"
	elog "after the first time you run gDesklets"
	echo

}

pkg_postrm() {

	gnome2_pkg_postrm
	# Cleanup after our cavalier python compilation
	# The function takes care of ${ROOT} for us
	python_mod_cleanup /usr/$(get_libdir)/gdesklets

}
