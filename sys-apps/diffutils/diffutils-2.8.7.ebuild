# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/diffutils/diffutils-2.8.7.ebuild,v 1.12 2004/12/09 05:07:21 vapier Exp $

inherit eutils flag-o-matic

DESCRIPTION="Tools to make diffs and compare files"
HOMEPAGE="http://www.gnu.org/software/diffutils/diffutils.html"
SRC_URI="ftp://alpha.gnu.org/gnu/diffutils/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 ~hppa ppc ~ppc64 ~x86"
IUSE="nls static"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Removes waitpid() call after pclose() on piped diff stream, closing
	# bug #11728, thanks to D Wollmann <converter@dalnet-perl.org>
	epatch ${FILESDIR}/diffutils-2.8.4-sdiff-no-waitpid.patch

	# Make sure we don't try generating the manpages ... this requires 
	# 'help2man' which is a perl app which is not available in a 
	# stage2 / stage3 ... don't DEPEND on it or we get a DEPEND loop :(
	# for more info, see #55479
	touch man/*.1
}

src_compile() {
	econf $(use_enable nls) || die "econf"
	use static && append-ldflags -static
	emake LDFLAGS="${LDFLAGS}" || die "make"
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc ChangeLog NEWS README

	# use the manpage from 'sys-apps/man-pages'
	rm -f "${D}"/usr/share/man/man1/diff.1*
}
