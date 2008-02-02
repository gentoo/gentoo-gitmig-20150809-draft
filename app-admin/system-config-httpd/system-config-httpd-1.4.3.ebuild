# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/system-config-httpd/system-config-httpd-1.4.3.ebuild,v 1.4 2008/02/02 15:09:16 hollow Exp $

inherit depend.apache python eutils rpm

# Tag for which Fedora Core version it's from
FCVER="7"
# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="1"

DESCRIPTION="Apache configuration tool"
HOMEPAGE="http://fedoraproject.org/wiki/SystemConfig/httpd"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.fc${FCVER}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="dev-libs/alchemist
	=dev-python/pygtk-2*
	dev-lang/python
	=dev-python/gnome-python-2*
	sys-apps/usermode
	dev-libs/libxslt"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool"

need_apache2

pkg_setup() {
	if ! built_with_use dev-libs/libxslt python; then
		local msg="Build dev-libs/libxslt with USE=python"
		eerror "$msg"
		die "$msg"
	fi
}

src_unpack() {
	rpm_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-gentooify.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	make_desktop_entry /usr/bin/${PN}

	fperms 644 /etc/pam.d/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
