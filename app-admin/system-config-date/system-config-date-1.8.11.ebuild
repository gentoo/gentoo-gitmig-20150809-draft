# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/system-config-date/system-config-date-1.8.11.ebuild,v 1.1 2006/12/20 06:21:40 dberkholz Exp $

inherit python eutils rpm

# Tag for which Fedora Core version it's from
FCVER="7"
# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="1"

DESCRIPTION="A graphical interface for modifying system date and time"
HOMEPAGE="http://fedora.redhat.com/projects/config-tools/"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.fc${FCVER}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="dev-lang/python
	net-misc/ntp
	=dev-python/pygtk-2*
	=dev-python/gnome-python-2*
	sys-apps/usermode
	dev-python/rhpl
	dev-libs/newt
	www-client/htmlview
	x11-themes/hicolor-icon-theme"
#	app-admin/anaconda
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool"

src_unpack() {
	rpm_src_unpack
	cd "${S}"
	epatch "${FILESDIR}"/1.8.5-gentooify.patch
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	make_desktop_entry /usr/bin/${PN}

	fperms 644 /etc/pam.d/{system-config-date,system-config-time,dateconfig}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
