# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.5.1-r1.ebuild,v 1.22 2004/06/15 07:06:41 solar Exp $

inherit gnuconfig flag-o-matic eutils

DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="http://www.gnu.org/software/grep/grep.html"
SRC_URI="http://ftp.club.cc.cmu.edu/pub/gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz
	mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc mips alpha arm hppa amd64 ia64 ppc64 s390"
IUSE="nls build uclibc"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	if [ "${ARCH}" = "sparc" -a "${PROFILE_ARCH}" = "sparc" ] ; then
		epatch ${FILESDIR}/gentoo-sparc32-dfa.patch
	fi
	use uclibc && epatch ${FILESDIR}/grep-2.5.1-restrict_arr.patch
}

src_compile() {
	# Fix configure scripts to detect linux-mips
	gnuconfig_update

	local myconf=""
	use nls || myconf="--disable-nls"
	use uclibc && myconf="${myconf} --without-included-regex"
	use static && append-flags -static && append-ldflags -static

	econf \
		--bindir=/bin \
		--disable-perl-regexp \
		${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	einstall bindir=${D}/bin || die "einstall failed"

	# Override the default shell scripts... grep knows how to act
	# based on how it's called
	ln -sfn grep ${D}/bin/egrep || die "ln egrep failed"
	ln -sfn grep ${D}/bin/fgrep || die "ln fgrep failed"

	if use build ; then
		rm -rf ${D}/usr/share
	else
		dodoc AUTHORS ChangeLog NEWS README THANKS TODO
	fi
}
