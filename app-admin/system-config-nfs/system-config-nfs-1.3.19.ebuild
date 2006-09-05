# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/system-config-nfs/system-config-nfs-1.3.19.ebuild,v 1.2 2006/09/05 21:55:42 dberkholz Exp $

inherit python eutils rpm

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="1.1"

DESCRIPTION="NFS server configuration tool"
HOMEPAGE="http://fedora.redhat.com/projects/config-tools/"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="=dev-python/pygtk-2*
	>=x11-libs/gtk+-2.6
	dev-lang/python
	net-fs/nfs-utils
	sys-apps/usermode
	dev-python/rhpl
	www-client/htmlview
	x11-themes/hicolor-icon-theme"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool"

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
