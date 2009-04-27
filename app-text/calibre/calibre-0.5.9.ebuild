# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/calibre/calibre-0.5.9.ebuild,v 1.1 2009/04/27 07:08:11 zmedico Exp $

NEED_PYTHON=2.6

inherit python distutils eutils fdo-mime bash-completion

MY_P="${P/_p/-p}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Ebook management application."
HOMEPAGE="http://calibre.kovidgoyal.net"
SRC_URI="http://calibre.kovidgoyal.net/downloads/${MY_P}.tar.gz"

LICENSE="GPL-2"

KEYWORDS="~amd64 ~x86"

SLOT="0"

IUSE=""

RDEPEND=">=dev-lang/python-2.6
	>=dev-python/setuptools-0.6_rc5
	>=dev-python/imaging-1.1.6
	>=dev-libs/libusb-0.1.12
	>=dev-python/PyQt4-4.4.2
	>=dev-python/mechanize-0.1.11
	>=media-gfx/imagemagick-6.3.5
	>=x11-misc/xdg-utils-1.0.2
	>=dev-python/dbus-python-0.82.2
	>=dev-python/lxml-2.1.5
	>=dev-python/python-dateutil-1.4.1
	>=dev-python/beautifulsoup-3.0.5
	>=dev-python/dnspython-1.6.0
	>=sys-apps/help2man-1.36.4"

DEPEND="${RDEPEND}
	dev-python/setuptools
	>=gnome-base/librsvg-2.0.0
	>=x11-misc/xdg-utils-1.0.2-r2
	sys-apps/help2man"

src_compile() {
	# Removing the post_install call. We'll do that stuff in src_install.
	sed -i -e "/if 'install'/,/subprocess.check_call/d" \
		setup.py || die "couldn't remove post_install call"
	# For help2man to succeed, we need to tell it the path to the tools.
	sed -i -e "s:\('help2man',\) \(prog\):\1 \'PYTHONPATH=\"${D}$(python_get_sitedir)\" \' + \'${D}usr/bin/\' + \2:" \
		src/calibre/linux.py || die "sed'ing in the IMAGE path failed"
	distutils_src_compile
}

src_install() {
	pushd "${S}"/build
	ln -s lib\.* lib
	popd
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

	# Move the bash-completion file and properly install it.
	mv "${D}"/etc/bash_completion.d/calibre "${S}/" \
		|| die "cannot move the bash-completion file"
	dobashcompletion "${S}"/calibre
	find "${D}"/etc -type d -empty -delete

	# Removing junk.
	rm -r "${D}"/usr/share/applications/{mimeinfo.cache,defaults.list} \
		"${D}"/usr/share/mime/{subclasses,XMLnamespaces,globs{,2},mime.cache,magic,aliases,{generic-,}icons} \
		"${D}"/usr/share/{applnk,desktop-directories}
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	distutils_pkg_postinst
}
