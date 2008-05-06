# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/einit/einit-0.40.0.ebuild,v 1.4 2008/05/06 14:24:12 opfer Exp $

EAPI="1"

inherit eutils python

DESCRIPTION="An alternate /sbin/init implementation"
SRC_URI="http://einit.jyujin.de/files/${P}.tar.bz2"
HOMEPAGE="http://einit.jyujin.de/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"

IUSE="debug doc +relaxng"

DEPEND="doc? ( app-text/docbook-sgml app-doc/doxygen )
		dev-util/scons"

RDEPEND=""

PDEPEND=">=sys-apps/einit-modules-xml-2.0.0.0
		 >=sys-apps/einit-modules-scheme-1.0.0.0
		 relaxng? ( app-text/rnv )"

pkg_setup() {
	enewgroup einit || die
	if [ $(getconf GNU_LIBPTHREAD_VERSION | cut -d " " -f 1) != "NPTL" ]; then
		break;
	fi
}

src_unpack() {
	unpack ${A} || die
	python_version || die
}

src_compile() {

	scons ${MAKEOPTS:--j2} libdir="$(get_libdir)" destdir="${D}/${ROOT}/" prefix="${ROOT}" || die
}

src_install() {
	scons libdir="$(get_libdir)" destdir="${D}/${ROOT}/" prefix="${ROOT}" install || die

	mkdir -p "${D}/${ROOT}/bin"
	ln -s ../sbin/einit "${D}/${ROOT}/bin/einit"
	ln -s ../"$(get_libdir)"/einit/bin/einit-log "${D}/${ROOT}/bin/einit-log"
	ln -s ../$(get_libdir)/einit/bin/einit-feedback "${D}/${ROOT}/bin/einit-feedback"

	doman documentation/man/*.8
}

pkg_postinst() {
	elog "eINIT is now installed, but you will still need to configure it."
	elog
	elog "To use einit as a non-root user, add that user to the group 'einit'."
	elog
	elog "You can always find the latest documentation at"
	elog "http://einit.org/"
	elog
}
