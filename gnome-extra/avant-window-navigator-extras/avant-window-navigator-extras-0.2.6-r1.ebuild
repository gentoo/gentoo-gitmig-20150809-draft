# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/avant-window-navigator-extras/avant-window-navigator-extras-0.2.6-r1.ebuild,v 1.5 2008/05/07 02:29:13 wltjr Exp $

inherit autotools eutils gnome2 python

MY_P="awn-extras-applets-${PV}"
DESCRIPTION="Applets for the avant-window-navigator"
HOMEPAGE="http://launchpad.net/awn-extras"
SRC_URI="https://launchpad.net/awn-extras/${PV%.*}/${PV}/+download/${MY_P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome"

DEPEND="dev-python/pyalsaaudio
	dev-python/feedparser
	gnome? (
		dev-python/gst-python
		dev-python/gnome-python-desktop
		gnome-base/gnome-menus
		gnome-base/librsvg
		gnome-base/libgtop
	)
	gnome-extra/avant-window-navigator
	x11-libs/libsexy
	x11-libs/libnotify"
RDEPEND="${DEPEND}"

DOCS="AUTHORS Changelog NEWS README"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if use gnome && ! built_with_use gnome-extra/avant-window-navigator gnome ; then
		eerror "Please re-emerge gnome-extra/avant-window-navigator with the gnome USE flag set"
		die "avant-window-navigator needs the gnome flag set"
	fi
}

src_unpack() {
	gnome2_src_unpack

	# Apply a fix from awn bzr to make gconf truly conditional.
	epatch "${FILESDIR}"/${PV}-r346-gconf-conditional.patch
	eautoreconf

	# Disable pyc compiling.
	mv py-compile py-compile.orig
	ln -s $(type -P true) py-compile
}

src_compile() {
	# Not disabling pymod-checks results in a sandbox access violation.
	econf --disable-pymod-checks \
			$(use_with gnome) \
			$(use_with gnome gconf) \
			|| die "econf failed"

	# temp hack to remove problem per bug #214984
	if ! use gnome && ! use xfce; then
		sed -i -e 's:--makefile-install-rule $(schemas_DATA)::' \
			"${S}/src/places/Makefile"
	fi

	emake || die "emake failed"
}

src_install() {
	gnome2_src_install

	if use gnome ; then
		# Give the gconf schemas non-conflicting names.
		mv "${D}/etc/gconf/schemas/notification-daemon.schemas" \
			"${D}/etc/gconf/schemas/awn-notification-daemon.schemas"
		mv "${D}/etc/gconf/schemas/awnsystemmonitor.schemas" \
			"${D}/etc/gconf/schemas/awn-system-monitor.schemas"
		mv "${D}/etc/gconf/schemas/filebrowser.schemas" \
			"${D}/etc/gconf/schemas/awn-filebrowser.schemas"
		mv "${D}/etc/gconf/schemas/switcher.schemas" \
			"${D}/etc/gconf/schemas/awn-switcher.schemas"
		mv "${D}/etc/gconf/schemas/trash.schemas" \
			"${D}/etc/gconf/schemas/awn-trash.schemas"
		mv "${D}/etc/gconf/schemas/shinyswitcher.schemas" \
			"${D}/etc/gconf/schemas/awn-shinyswitcher.schemas"
		mv "${D}/etc/gconf/schemas/places.schemas" \
			"${D}/etc/gconf/schemas/awn-places.schemas"
	fi
}

pkg_postinst() {
	gnome2_pkg_postinst
	python_version
	python_mod_optimize "${ROOT}"/usr/$(get_libdir)/python${PYVER}/site-packages/awn/extras
}

pkg_postrm() {
	gnome2_pkg_postrm
	python_version
	python_mod_cleanup /usr/$(get_libdir)/python${PYVER}/site-packages/awn/extras
}
