# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtkgl-sharp/gtkgl-sharp-0.05.ebuild,v 1.12 2008/11/27 18:51:12 ssuominen Exp $

inherit mono

DESCRIPTION="A C# OpenGL Binding"
HOMEPAGE="http://www.olympum.com/~bruno/gtkgl-sharp.html"
SRC_URI="http://ftp.novell.com/pub/forge/simetron/${PN}/${PV}/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""

RDEPEND=">=dev-lang/mono-0.91
    =dev-dotnet/gtk-sharp-1.0*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}
