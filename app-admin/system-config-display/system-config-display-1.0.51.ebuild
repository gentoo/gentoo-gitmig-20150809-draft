# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/system-config-display/system-config-display-1.0.51.ebuild,v 1.4 2008/03/20 00:17:57 dberkholz Exp $

inherit python rpm

# Tag for which Fedora Core version it's from
FCVER="8"
# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="2"

DESCRIPTION="A graphical interface for configuring the X Window System display"
HOMEPAGE="http://fedoraproject.org/wiki/SystemConfig/display"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.fc${FCVER}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""
RDEPEND="=dev-python/pygtk-2*
	>=x11-libs/gtk+-2.6
	dev-lang/python
	sys-apps/usermode
	sys-apps/hwdata-redhat
	sys-apps/kudzu
	dev-python/pyxf86config
	dev-python/rhpl
	>=dev-python/rhpxl-0.34
	dev-util/desktop-file-utils
	x11-base/xorg-server
	x11-themes/hicolor-icon-theme"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool"

src_install() {
	emake INSTROOT="${D}" install || die "emake install failed"

	make_desktop_entry /usr/bin/${PN}

	fperms 644 /etc/pam.d/${PN}
}

pkg_postinst() {
	elog "If you want card autodetection to work optimally, you must reinstall"
	elog "any video driver packages that did not install a *.xinf file"
	elog "to /usr/share/hwdata/videoaliases/"
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
