# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/cdrkit/cdrkit-1.1.10.ebuild,v 1.8 2010/12/28 11:05:30 lxnay Exp $

inherit cmake-utils

DESCRIPTION="A set of tools for CD/DVD reading and recording, including cdrecord"
HOMEPAGE="http://cdrkit.org"
SRC_URI="mirror://debian/pool/main/c/${PN}/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 s390 sparc x86 ~x86-fbsd"
IUSE="debug hfs unicode"

RDEPEND="!app-cdr/cdrtools
	unicode? ( virtual/libiconv )
	kernel_linux? ( sys-libs/libcap )"
DEPEND="${RDEPEND}
	hfs? ( sys-apps/file )"

src_install() {
	cmake-utils_src_install

	local msuffix=$(ecompress --suffix)

	dosym wodim /usr/bin/cdrecord || die
	dosym genisoimage /usr/bin/mkisofs || die
	dosym icedax /usr/bin/cdda2wav || die
	dosym readom /usr/bin/readcd || die
	dosym wodim.1${msuffix} /usr/share/man/man1/cdrecord.1${msuffix}
	dosym genisoimage.1${msuffix} /usr/share/man/man1/mkisofs.1${msuffix}
	dosym icedax.1${msuffix} /usr/share/man/man1/cdda2wav.1${msuffix}
	dosym readom.1${msuffix} /usr/share/man/man1/readcd.1${msuffix}

	dodoc ABOUT Changelog FAQ FORK TODO doc/{PORTABILITY,WHY}

	for x in genisoimage plattforms wodim icedax; do
		docinto ${x}
		dodoc doc/${x}/*
	done

	insinto /etc
	newins wodim/wodim.dfl wodim.conf || die
	newins netscsid/netscsid.dfl netscsid.conf || die

	insinto /usr/include/scsilib
	doins include/*.h || die
	insinto /usr/include/scsilib/usal
	doins include/usal/*.h || die
	dosym usal /usr/include/scsilib/scg || die
}
