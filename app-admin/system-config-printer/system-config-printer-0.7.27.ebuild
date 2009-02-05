# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/system-config-printer/system-config-printer-0.7.27.ebuild,v 1.6 2009/02/05 05:31:59 darkside Exp $

inherit python rpm

# Revision of the RPM. Shouldn't affect us, as we're just grabbing the source
# tarball out of it
RPMREV="1"

DESCRIPTION="A printer administration tool"
HOMEPAGE="http://cyberelk.net/tim/software/system-config-printer/"
SRC_URI="mirror://fedora/development/source/SRPMS/${P}-${RPMREV}.src.rpm"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""
# pygobject comes from gnome-experimental overlay
RDEPEND="net-print/cups
	dev-lang/python
	=dev-python/pygtk-2*
	dev-python/pycups
	sys-apps/usermode
	dev-python/rhpl
	net-print/foomatic-filters
	net-print/foomatic-db
	dev-python/pyxml"
DEPEND="${RDEPEND}
	sys-devel/gettext
	dev-util/intltool"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	make_desktop_entry /usr/bin/${PN}

	fperms 644 /etc/pam.d/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/share/${PN}
}
