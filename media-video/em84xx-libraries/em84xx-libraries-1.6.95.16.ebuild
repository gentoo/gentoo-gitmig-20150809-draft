# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/em84xx-libraries/em84xx-libraries-1.6.95.16.ebuild,v 1.1 2007/05/21 19:53:34 zzam Exp $

inherit eutils

MY_P=Netstream2000-${PV}

DESCRIPTION="libraries for the em84xx chip"
HOMEPAGE="ftp://ftp.sigmadesigns.com/NetStr_2000/"
SRC_URI="ftp://ftp.sigmadesigns.com/NetStr_2000/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${MY_P}RC

pkg_setup() {
	if built_with_use -a sys-libs/glibc glibc-compat20 -nptlonly; then
		einfo "Use-flags of glibc checked ok."
	else
		eerror "You cannot use ${P} with your glibc use-flags."
		eerror "Please recompile glibc with USE=\"glibc-compat20 -nptlonly\""
	fi
}

src_install() {
	insinto /usr/lib
	doins lib/libEM84xx.so lib/libosd.so

	insinto /usr/include/em84xx/
	doins include/*.h
}

