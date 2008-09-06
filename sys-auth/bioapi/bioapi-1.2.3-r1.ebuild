# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/bioapi/bioapi-1.2.3-r1.ebuild,v 1.1 2008/09/06 05:29:07 vapier Exp $

inherit eutils multilib

DESCRIPTION="Framework for biometric-based authentication"
HOMEPAGE="http://code.google.com/p/bioapi-linux/"
SRC_URI="http://bioapi-linux.googlecode.com/files/${PN}_${PV}.tar.gz"

LICENSE="bioapi"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt3"

DEPEND="qt3? ( =x11-libs/qt-3* )"

S=${WORKDIR}/bioapi-linux

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-enroll-ret.patch #236654
}

src_compile() {
	econf $(use_with qt3 Qt-dir /usr/qt/3) || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	emake SKIPCONFIG=true DESTDIR="${D}" install || die "install failed"
	dodoc README
	dohtml *.htm

	# rename generic binaries
	mv "${D}"/usr/bin/{,BioAPI}Sample || die
	if use qt3 ; then
		mv "${D}"/usr/bin/{,BioAPI}QSample || die
	fi
}

pkg_config() {
	mds_install -s /usr/$(get_libdir)
	mod_install -fi /usr/$(get_libdir)/libbioapi100.so
	mod_install -fi /usr/$(get_libdir)/libbioapi_dummy100.so
	mod_install -fi /usr/$(get_libdir)/libpwbsp.so
	use qt3 && mod_install -fi /usr/$(get_libdir)/libqtpwbsp.so
}

pkg_preinst() {
	if [[ -e ${ROOT}/var/bioapi ]] && [[ ! -e ${ROOT}/var/lib/bioapi ]] ; then
		einfo "Moving /var/bioapi to /var/lib/bioapi"
		dodir /var/lib
		mv "${ROOT}"/var/bioapi "${ROOT}"/var/lib/bioapi
	fi
}

pkg_postinst() {
	einfo "Some generic-named programs have been renamed:"
	einfo "  Sample -> BioAPISample"
	einfo "  QSample -> BioAPIQSample"

	if [[ ${ROOT} == "/" ]] ; then
		pkg_config
	else
		ewarn "You will need to run 'emerge --config bioapi' before"
		ewarn " you can use bioapi properly."
	fi

	# XXX: this can't be correct ...
	enewgroup bioapi
	chgrp bioapi "${ROOT}"/var/lib/bioapi -R
	chmod g+w,o= "${ROOT}"/var/lib/bioapi -R
	einfo "Note: users using bioapi must be in group bioapi."
}

pkg_prerm() {
	mod_install -fu libbioapi100.so
	mod_install -fu libbioapi_dummy100.so
	mod_install -fu libpwbsp.so
	use qt3 && mod_install -fu libqtpwbsp.so
}
