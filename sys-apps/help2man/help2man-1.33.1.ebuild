# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/help2man/help2man-1.33.1.ebuild,v 1.5 2004/06/11 13:35:10 kloeri Exp $

MY_P="${P/-/_}"
DESCRIPTION="GNU utility to convert program --help output to a man page"
HOMEPAGE="http://www.gnu.org/software/help2man"
SRC_URI="http://ftp.gnu.org/gnu/help2man/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc alpha arm s390 ~amd64"
IUSE="nls"

DEPEND="dev-lang/perl
	nls? ( dev-perl/Locale-gettext
		>=sys-devel/gettext-0.12.1-r1 )"

src_compile() {
	econf `use_enable nls` || die
	emake || die "emake failed"
}

src_install(){
	make DESTDIR=${D} install || die "make install failed"
	dodoc ChangeLog NEWS README THANKS
}
