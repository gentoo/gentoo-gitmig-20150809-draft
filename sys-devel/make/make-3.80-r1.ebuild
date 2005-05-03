# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/make/make-3.80-r1.ebuild,v 1.5 2005/05/03 03:08:35 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Standard tool to compile source trees"
HOMEPAGE="http://www.gnu.org/software/make/make.html"
SRC_URI="ftp://ftp.gnu.org/gnu/make/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE="nls static build uclibc hardened"

DEPEND="nls? ( sys-devel/gettext )"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PV}-memory.patch
	if use ppc64 && use hardened ; then
		epatch "${FILESDIR}"/make-3.80-ppc64-hardened-clock_gettime.patch
	fi
}

src_compile() {
	use static && append-ldflags -static
	econf $(use_enable nls) || die
	emake || die
}

src_install() {
	if use build ; then
		dobin make || die
	else
		make DESTDIR="${D}" install || die "make install failed"

		fperms 0755 /usr/bin/make
		dosym make /usr/bin/gmake

		dodoc AUTHORS ChangeLog NEWS README*
	fi
}
