# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/firstboot/firstboot-1.4.19.ebuild,v 1.3 2007/10/15 09:35:28 dberkholz Exp $

inherit python rpm

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="1"

DESCRIPTION="Initial system configuration utility"
HOMEPAGE="http://fedoraproject.org/wiki/FirstBoot"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="=dev-python/pygtk-2*
	dev-python/rhpl
	dev-python/rhpxl
	app-admin/system-config-display
	app-admin/system-config-language
	app-admin/system-config-soundcard
	app-admin/system-config-users
	app-admin/system-config-date
	app-admin/system-config-keyboard
	app-admin/authconfig
	sys-libs/libuser"
# Incompatible with Gentoo, so we don't use these modules.
#	app-admin/system-config-network
#	app-admin/system-config-securitylevel
DEPEND="${RDEPEND}
	sys-devel/gettext"

src_install() {
	emake \
		INSTROOT="${D}" \
		RPM_BUILD_ROOT="${D}" \
		install \
		|| die "emake install failed"

	rm -f "${D}"/usr/share/modules/{additional_cds.py,networking.py}

	rm -rf "${D}"/etc/rc.d

	make_desktop_entry /usr/bin/${PN}

	fperms 644 /etc/pam.d/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
