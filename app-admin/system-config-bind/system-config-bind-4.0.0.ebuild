# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/system-config-bind/system-config-bind-4.0.0.ebuild,v 1.1 2006/09/05 21:16:46 dberkholz Exp $

inherit eutils rpm

# Tag for which Fedora Core version it's from
FCVER="6"
# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="44"

DESCRIPTION="The Red Hat BIND DNS Configuration Tool"
HOMEPAGE="http://fedora.redhat.com/projects/config-tools/"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.fc${FCVER}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
RDEPEND="=dev-python/pygtk-2*
	dev-lang/python
	=dev-python/gnome-python-2*
	net-dns/bind
	net-dns/bind-tools
	net-dns/bind-dns-keygen
	x11-themes/hicolor-icon-theme"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool"

src_unpack() {
	rpm_src_unpack
	cd "${S}"

	# by default it uses /etc/named.conf, not /etc/bind/named.conf
	epatch "${FILESDIR}"/${PV}-use-etc-bind-directory.patch
}

src_install() {
	emake ROOT="${D}" install || die "emake install failed"

	make_desktop_entry /usr/bin/${PN}

	fperms 644 /etc/pam.d/{system-config-bind,bindconf}

	# It assumes this file already exists. This is the equivalent
	# of /etc/conf.d/named, so this is where arguments to named end up.
	dodir /etc/sysconfig
	touch "${D}"/etc/sysconfig/named
}
