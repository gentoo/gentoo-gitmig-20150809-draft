# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtksourceview-sharp/gtksourceview-sharp-0.10.ebuild,v 1.2 2005/05/21 09:31:03 slarti Exp $

inherit mono multilib

MY_P="${P/${PN}/${PN}-2.0}"

DESCRIPTION="A C# Binding to gtksourceview"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}-2.0/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""

S=${WORKDIR}/${MY_P}

DEPEND=">=dev-lang/mono-1.0
		>=dev-dotnet/gtk-sharp-2.5.5
		>=dev-dotnet/gnome-sharp-2.5.5
		>=x11-libs/gtksourceview-1.2.0"


src_unpack() {
	unpack ${A}
	sed -i "s:\`monodoc:${D}\`monodoc:" ${S}/doc/Makefile.in
}

src_compile() {
	econf || die "./configure failed!"
	emake -j1 || die "make failed"
}

src_install() {
	dodir $(monodoc --get-sourcesdir)
	make GACUTIL_FLAGS="/root ${D}/usr/$(get_libdir) /gacdir /usr/$(get_libdir) -package gtksourceview-sharp-2.0" \
		DESTDIR=${D} install || die

	# newer gtksourceview versions install these
	rm ${D}/usr/share/gtksourceview-1.0/language-specs/{vbnet,nemerle}.lang
}
