# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrecord-prodvd/cdrecord-prodvd-2.01_pre20041012.ebuild,v 1.2 2005/05/30 03:01:42 solar Exp $

AMD64_FILENAME="${PN}-2.01-pre-x86_64-unknown-linux-gnu"

DESCRIPTION="Enhancement of cdrecord for writing DVDs"
HOMEPAGE="http://ftp.berlios.de/pub/cdrecord/ProDVD/"
SRC_URI="amd64? ( ftp://ftp.berlios.de/pub/cdrecord/ProDVD/${AMD64_FILENAME} )"

LICENSE="free-noncomm"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE=""

DEPEND=">=app-cdr/cdrtools-2.01_alpha24"

S=${WORKDIR}

src_unpack() {
	use elibc_glibc || die "binary package not compatible with any libc other than glibc"
	cp ${DISTDIR}/${A} ${WORKDIR}/
}

src_install() {
	dobin ${A}
	dosym ${A} /usr/bin/cdrecord-ProDVD
	dobin ${FILESDIR}/cdrecord-wrapper.sh
}

pkg_postinst() {
	echo
	einfo "For a license key of CDrecord-ProDVD please read"
	einfo "ftp://ftp.berlios.de/pub/cdrecord/ProDVD/README"
	einfo "or use cdrecord-wrapper.sh"
	echo
}
