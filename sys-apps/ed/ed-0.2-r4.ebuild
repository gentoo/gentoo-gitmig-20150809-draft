# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/ed/ed-0.2-r4.ebuild,v 1.10 2004/11/12 15:53:39 vapier Exp $

inherit eutils

DESCRIPTION="Your basic line editor"
HOMEPAGE="http://www.gnu.org/software/ed/"
SRC_URI="ftp://ftp.gnu.org/pub/gnu/ed/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="virtual/libc
	sys-apps/texinfo"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-info-dir.patch
	epatch ${FILESDIR}/${PV}-mkstemp.patch
}

src_compile() {
	# very old configure script ... econf wont work
	local myconf="--prefix=/ --host=${CHOST}"
	[ ! -z "${CBUILD}" ] && myconf="${myconf} --build=${CBUILD}"
	myconf="${myconf} ${EXTRA_ECONF}"
	echo "./configure ${myconf}"
	./configure ${myconf} || die
	emake || die
}

src_install() {
	chmod 0644 ${S}/ed.info
	make \
		prefix=${D}/ \
		mandir=${D}/usr/share/man/man1 \
		infodir=${D}/usr/share/info \
		install || die
	dodoc ChangeLog NEWS POSIX README THANKS TODO
}
