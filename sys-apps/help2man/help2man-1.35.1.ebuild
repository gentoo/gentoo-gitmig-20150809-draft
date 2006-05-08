# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/help2man/help2man-1.35.1.ebuild,v 1.6 2006/05/08 03:57:44 flameeyes Exp $

DESCRIPTION="GNU utility to convert program --help output to a man page"
HOMEPAGE="http://www.gnu.org/software/help2man"
SRC_URI="http://ftp.gnu.org/gnu/help2man/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ia64 ~m68k ~mips ~ppc ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
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
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog NEWS README THANKS
}
