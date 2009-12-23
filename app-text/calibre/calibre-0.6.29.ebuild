# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/calibre/calibre-0.6.29.ebuild,v 1.1 2009/12/23 10:15:18 zmedico Exp $

EAPI=2
NEED_PYTHON=2.6

inherit python distutils eutils fdo-mime bash-completion

DESCRIPTION="Ebook management application."
HOMEPAGE="http://calibre-ebook.com/"
SRC_URI="http://calibre-ebook.googlecode.com/files/$P.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"

SLOT="0"

IUSE=""

# libusb-compat is untested
SHARED_DEPEND=">=dev-lang/python-2.6[sqlite]
	>=dev-python/setuptools-0.6_rc5
	>=dev-python/imaging-1.1.6
	>=dev-libs/libusb-0.1.12:0
	>=dev-python/PyQt4-4.5[X,svg,webkit]
	>=dev-python/mechanize-0.1.11
	>=media-gfx/imagemagick-6.3.5
	>=x11-misc/xdg-utils-1.0.2
	>=dev-python/dbus-python-0.82.2
	>=dev-python/lxml-2.1.5
	>=dev-python/python-dateutil-1.4.1
	>=dev-python/beautifulsoup-3.0.5
	>=dev-python/dnspython-1.6.0
	>=virtual/poppler-0.12.0
	>=sys-apps/help2man-1.36.4
	app-text/podofo"

RDEPEND="$SHARED_DEPEND
	>=dev-python/reportlab-2.1"

DEPEND="$SHARED_DEPEND
	dev-python/setuptools
	>=gnome-base/librsvg-2.0.0
	>=x11-misc/xdg-utils-1.0.2-r2
	sys-apps/help2man"

S=$WORKDIR/$PN

src_prepare() {
	# Avoid sandbox violation in /usr/share/gnome/apps when linux.py
	# calls xdg-* (bug #258938).
	sed -e "s:'xdg-desktop-menu', 'install':'xdg-desktop-menu', 'install', '--mode', 'user':" \
		-e "s:xdg-icon-resource install:xdg-icon-resource install --mode user:" \
		-e "s:xdg-mime install:xdg-mime install --mode user:" \
		-e "s:old_udev = '/etc:old_udev = '${D}etc:" \
		-i src/calibre/linux.py || die "sed'ing in the IMAGE path failed"

	# Disable unnecessary privilege dropping for bug #287067.
	sed -e "s:if os.geteuid() == 0:if False and os.geteuid() == 0:" \
		-i setup/install.py || die "sed'ing in the IMAGE path failed"

	distutils_src_prepare
}

src_install() {

	# Bypass kbuildsycoca and update-mime-database in order to
	# avoid sandbox violations if xdg-mime tries to call them.
	cat - > "${T}/kbuildsycoca" <<-EOF
	#!$BASH
	exit 0
	EOF

	cp "${T}"/{kbuildsycoca,update-mime-database}
	chmod +x "${T}"/{kbuildsycoca,update-mime-database}

	# --bindir and --sharedir don't seem to work.
	# Pass them in anyway so we'll know when they are fixed.
	# Unset DISPLAY in order to prevent xdg-mime from triggering a sandbox
	# violation with kbuildsycoca as in bug #287067, comment #13.
	export -n DISPLAY

	# Bug #295672 - Aavoid sandbox violation in ~/.config by forcing
	# variables to point to our fake temporary $HOME.
	export XDG_CONFIG_HOME="$HOME/.config"
	export CALIBRE_CONFIG_DIRECTORY="$XDG_CONFIG_HOME/calibre"
	mkdir -p "$XDG_CONFIG_HOME" "$CALIBRE_CONFIG_DIRECTORY"

	PATH=${T}:${PATH} PYTHONPATH=${S}/src${PYTHONPATH:+:}${PYTHONPATH} \
		distutils_src_install --bindir="${D}usr/bin" --sharedir="${D}usr/share"

	grep -rlZ "${D}" "${D}" | xargs -0 sed -e "s:${D}:/:g" -i ||
		die "failed to fix harcoded \$D in paths"

	# Python modules are no longer installed in
	# site-packages, so remove empty dirs.
	find "${D}$(python_get_libdir)" -type d -empty -delete

	# This code may fail if behavior of --root, --bindir or
	# --sharedir changes in the future.
	dodir /usr/lib
	mv "${D}lib/calibre" "${D}usr/lib/" ||
		die "failed to move lib dir"
	find "${D}"lib -type d -empty -delete

	dodir /usr/bin
	mv "${D}bin/"* "${D}usr/bin/" ||
		die "failed to move bin dir"
	find "${D}"bin -type d -empty -delete

	dodir /usr/share
	mv "${D}share/"* "${D}usr/share/" ||
		die "failed to move share dir"
	find "${D}"share -type d -empty -delete

	# The menu entries end up here due to '--mode user' being added to
	# xdg-* options in src_prepare.
	dodir /usr/share/mime/packages
	chmod -fR a+rX,u+w,g-w,o-w "$HOME"/.local
	mv "$HOME"/.local/share/mime/packages/* "$D"usr/share/mime/packages/ ||
		die "failed to register mime types"
	dodir /usr/share/icons
	mv "$HOME"/.local/share/icons/* "$D"usr/share/icons/ ||
		die "failed to install icon files"
	domenu "$HOME"/.local/share/applications/*.desktop ||
		die "failed to install .desktop menu files"

	dobashcompletion "$D"etc/bash_completion.d/calibre
	rm -r "${D}"etc/bash_completion.d
	find "${D}"etc -type d -empty -delete
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	distutils_pkg_postinst
	bash-completion_pkg_postinst
}
