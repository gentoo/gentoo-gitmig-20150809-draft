# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/calibre/calibre-0.4.77.ebuild,v 1.2 2009/04/14 09:48:41 armin76 Exp $

NEED_PYTHON=2.5

inherit distutils eutils fdo-mime

MY_P="${P/_p/-p}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Ebook management application."
HOMEPAGE="http://calibre.kovidgoyal.net"
SRC_URI="http://calibre.kovidgoyal.net/downloads/${MY_P}.tar.bz2"

LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"

SLOT="0"

IUSE=""

RDEPEND=">=dev-python/imaging-1.1.6
	>=dev-libs/libusb-0.1.12
	>=dev-python/PyQt4-4.3.1
	>=dev-python/fonttools-2.0_beta1
	>=app-text/unrtf-0.20.1
	>=dev-python/mechanize-0.1.7b
	>=media-gfx/imagemagick-6.3.5
	>=dev-python/dbus-python-0.82.2
	>=app-text/convertlit-1.8
	>=dev-python/lxml-1.3.3
	dev-python/ttfquery
	dev-python/genshi"

DEPEND="${RDEPEND}
	dev-python/setuptools
	>=gnome-base/librsvg-2.0.0
	>=x11-misc/xdg-utils-1.0.2-r2
	sys-apps/help2man"

src_compile() {
	emake || die "pre-build failed"
	distutils_src_compile
}

src_install() {
	distutils_src_install

	# Create directory before running the postinst script
	# otherwise it will bail out.
	dodir /usr/share/icons/hicolor
	dodir /etc/xdg/menus
	dodir /usr/share/applications
	dodir /usr/share/desktop-directories
	dodir /usr/share/applnk
	dodir /usr/share/mime/packages

	# Bypass the default kde-config output, and force it to
	# tell xdg-mime to use a different path.
	cat - > "${T}/kde-config" <<EOF
#!/bin/bash

case \$1:\$2 in
	--version:) echo -e "Qt: 3.3.8\nKDE: 3.5.8\nkde-config: 1.0" ;;
	--path:mime) echo "${D}/usr/share/mimelnk/" ;;
esac
EOF

	chmod +x "${T}/kde-config"

	PATH="${T}:${PATH}" KDEDIRS="${D}/usr" XDG_DATA_DIRS="${D}/usr/share" DESTDIR="${D}" PYTHONPATH="${S}/build/lib" \
		python "${S}"/src/${PN}/linux.py \
		--use-destdir --do-not-reload-udev-hal \
		--group-file="${ROOT}"/etc/group --dont-check-root \
		|| die "post-installation failed."

	rm -r "${D}"/usr/share/applications/{mimeinfo.cache,defaults.list} \
		"${D}"/usr/share/mime/{subclasses,XMLnamespaces,globs{,2},mime.cache,magic,aliases,{generic-,}icons} \
		"${D}"/usr/share/applnk
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	distutils_pkg_postinst
}
