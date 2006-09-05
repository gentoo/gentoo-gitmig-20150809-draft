# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/authconfig/authconfig-5.3.5.ebuild,v 1.1 2006/09/05 21:00:35 dberkholz Exp $

inherit eutils rpm

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="1"

DESCRIPTION="Tool for setting up authentication from network services"
HOMEPAGE="http://fedora.redhat.com/projects/config-tools/"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="dev-python/rhpl
	dev-libs/newt
	>=sys-libs/pam-0.99.5
	sys-apps/usermode
	dev-lang/python
	=dev-libs/glib-2*
	dev-perl/XML-Parser
	=dev-python/pygtk-2*"
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

pkg_postinst() {
	elog "To activate options in the User Information tab,"
	elog "install the nss_XXX package or another provider of the nss module."
	elog "To activate options in the Authentication tab,"
	elog "install the pam_XXX package or another provider of the pam module."
}
