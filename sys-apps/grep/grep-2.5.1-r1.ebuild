# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/grep/grep-2.5.1-r1.ebuild,v 1.15 2003/12/17 03:54:50 brad_mssw Exp $

inherit gnuconfig flag-o-matic

IUSE="nls build"

DESCRIPTION="GNU regular expression matcher"
HOMEPAGE="http://www.gnu.org/software/grep/grep.html"
SRC_URI="http://ftp.club.cc.cmu.edu/pub/gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz
	mirror://gnu/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ppc sparc alpha mips hppa arm ia64 ppc64"

DEPEND="virtual/glibc
	nls? ( sys-devel/gettext )"
RDEPEND="virtual/glibc"

src_unpack() {
	unpack ${A}
	cd ${S}
	if [ "${ARCH}" = "sparc" -a "${PROFILE_ARCH}" = "sparc" ] ; then
		epatch ${FILESDIR}/gentoo-sparc32-dfa.patch
	fi
}

src_compile() {
	# Fix configure scripts to detect linux-mips
	gnuconfig_update

	local myconf=""
	use nls || myconf="--disable-nls"
	use static && append-flags -static && LDFLAGS="${LDFLAGS} -static"

	econf \
		--bindir=/bin \
		--disable-perl-regexp \
		${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	einstall bindir=${D}/bin || die "einstall failed"

	if use build; then
		rm -rf ${D}/usr/share
	else
		dodoc AUTHORS COPYING ChangeLog NEWS README THANKS TODO
	fi
}
