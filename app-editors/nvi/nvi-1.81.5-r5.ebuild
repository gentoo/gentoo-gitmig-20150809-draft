# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/nvi/nvi-1.81.5-r5.ebuild,v 1.9 2007/03/21 16:11:58 wolf31o2 Exp $

inherit eutils

DESCRIPTION="Vi clone"
HOMEPAGE="http://www.bostic.com/vi/"
SRC_URI="http://www.kotnet.org/~skimo/nvi/devel/${P}.tar.gz"

LICENSE="Sleepycat"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~mips ppc ppc64 sparc x86"
IUSE="perl" # unicode

DEPEND="=sys-libs/db-4*"
RDEPEND="${DEPEND}
	app-admin/eselect-vi"
PROVIDE="virtual/editor"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	# Fix bug 23888
	epatch "${FILESDIR}"/${P}-tcsetattr.patch
	# Fix bug 150169
	epatch "${FILESDIR}"/${P}-wide.patch
	epatch "${FILESDIR}"/${P}-gcc4.patch
	epatch "${FILESDIR}"/${P}-db4.patch
	touch "${S}"/dist/{configure,aclocal.m4,Makefile.in,stamp-h.in}
}

src_compile() {
	local myconf

	use perl && myconf="${myconf} --enable-perlinterp"
	#use unicode && myconf="${myconf} --enable-widechar"

	cd build.unix
	ECONF_SOURCE=../dist econf \
		--program-prefix=n \
		${myconf} \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	cd build.unix
	emake -j1 DESTDIR="${D}" install || die "install failed"
}

pkg_postinst() {
	einfo "Setting /usr/bin/vi symlink"
	eselect vi set "${PN}"
}

pkg_postrm() {
	einfo "Updating /usr/bin/vi symlink"
	eselect vi update
}
