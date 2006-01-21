# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtksourceview-sharp/gtksourceview-sharp-0.10-r1.ebuild,v 1.1 2006/01/21 19:50:37 latexer Exp $

inherit mono multilib eutils

MY_P="${P/${PN}/${PN}-2.0}"

DESCRIPTION="A C# Binding to gtksourceview"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}-2.0/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""

S=${WORKDIR}/${MY_P}

RDEPEND=">=dev-lang/mono-1.0
	>=dev-dotnet/gtk-sharp-2.4.0
	>=dev-dotnet/gnome-sharp-2.4.0
	>=x11-libs/gtksourceview-1.2.0"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/automake
	sys-devel/autoconf
	>=dev-util/monodoc-1.1.8"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-monodoc-update.diff

	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e 's:$(prefix)/lib:$(libdir):' \
			-e 's:${prefix}/lib:${libdir}:' \
			${S}/Makefile.{am,in} ${S}/*.pc.in || die
	fi

	aclocal || die
	automake || die
	autoconf || die

}

src_compile() {
	econf || die "./configure failed!"
	emake -j1 || die "make failed"
}

src_install() {
	dodir $(pkg-config --variable=sourcesdir monodoc)
	make GACUTIL_FLAGS="/root ${D}/usr/$(get_libdir) /gacdir /usr/$(get_libdir) -package gtksourceview-sharp-2.0" \
		DESTDIR=${D} install || die

	# newer gtksourceview versions install these
	rm ${D}/usr/share/gtksourceview-1.0/language-specs/{vbnet,nemerle}.lang
}
