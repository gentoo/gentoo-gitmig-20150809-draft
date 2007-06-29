# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mono-fuse/mono-fuse-0.4.0.ebuild,v 1.4 2007/06/29 11:32:10 jurek Exp $

inherit autotools mono

DESCRIPTION="C# binding for the FUSE library"
HOMEPAGE="http://www.jprl.com/Projects/mono-fuse/"
SRC_URI="http://www.jprl.com/Projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/mono-1.1.13
		>=dev-util/monodoc-1.1.13
		>=sys-fs/fuse-2.5.2"

src_unpack() {
	unpack ${A}
	cd ${S}

	sed -i -e 's#^AC_CHECK_LIB(MonoPosixHelper.*$##' \
		configure.in || die "sed failed"

	eautoreconf || die "eautoreconf failed"
}

src_compile()
{
	econf || die "configure failed"
	emake -j1 || die "make failed"
}

src_install()
{
	emake DESTDIR="${D}" install || die "install failed"

	dodoc ChangeLog README COPYING

	insinto /usr/share/doc/${PF}
	doins -r example
}

pkg_postinst()
{
	elog "Ensure that you have the fuse module loaded"
	elog "before you start using mono-fuse"
}
