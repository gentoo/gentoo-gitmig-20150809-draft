# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/help2man/help2man-1.36.4.ebuild,v 1.11 2006/10/17 09:41:34 uberlord Exp $

DESCRIPTION="GNU utility to convert program --help output to a man page"
HOMEPAGE="http://www.gnu.org/software/help2man"
SRC_URI="mirror://gnu/help2man/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE="nls"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	elibc_glibc? ( nls? ( dev-perl/Locale-gettext
		>=sys-devel/gettext-0.12.1-r1 ) )"

src_compile() {
	local myconf
	use elibc_glibc && myconf="${myconf} $(use_enable nls)" \
		|| myconf="${myconf} --disable-nls"

	econf ${myconf} || die
	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog NEWS README THANKS
}
