# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/mono-fuse/mono-fuse-0.4.0.ebuild,v 1.3 2007/06/22 17:46:04 jurek Exp $

inherit mono

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
