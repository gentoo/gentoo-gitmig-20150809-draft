# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrecord-prodvd/cdrecord-prodvd-2.01_beta31.ebuild,v 1.4 2004/10/31 00:46:59 pylon Exp $

X86_FILENAME="cdrecord-prodvd-2.01b31-i686-pc-linux-gnu"

DESCRIPTION="Enhancement of cdrecord for writing DVDs"
HOMEPAGE="http://www.fokus.gmd.de/research/cc/glone/employees/joerg.schilling/private/cdrecord.html"
SRC_URI="x86? ( ftp://ftp.berlios.de/pub/cdrecord/ProDVD/${X86_FILENAME} )
	 amd64? ( ftp://ftp.berlios.de/pub/cdrecord/ProDVD/${X86_FILENAME} )"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~amd64 -ppc -sparc -mips -alpha"
IUSE="uclibc"

DEPEND=">=app-cdr/cdrtools-2.01_alpha24
	!uclibc? ( sys-libs/glibc )"

S=${WORKDIR}

src_unpack() {
	use uclibc && die "binary package not compatible with uclibc"
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
	echo
}
