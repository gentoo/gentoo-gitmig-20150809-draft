# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/system-config-httpd/system-config-httpd-1.3.3.ebuild,v 1.2 2006/09/05 21:54:33 dberkholz Exp $

inherit python eutils rpm

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="1.1.1"

DESCRIPTION="Apache configuration tool"
HOMEPAGE="http://fedora.redhat.com/projects/config-tools/"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="dev-libs/alchemist
	=dev-python/pygtk-2*
	dev-lang/python
	=dev-python/gnome-python-2*
	>=net-www/apache-2.0.52-r3
	sys-apps/usermode
	dev-libs/libxslt"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool"

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
