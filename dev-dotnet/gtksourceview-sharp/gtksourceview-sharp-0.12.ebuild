# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gtksourceview-sharp/gtksourceview-sharp-0.12.ebuild,v 1.1 2008/11/26 15:08:33 loki_val Exp $

EAPI=2

inherit mono multilib

MY_P="${P/${PN}/${PN}-2.0}"

DESCRIPTION="A C# Binding to gtksourceview"
HOMEPAGE="http://www.go-mono.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}-2.0/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="~x86 ~ppc ~amd64"

IUSE=""

S=${WORKDIR}/${MY_P}

RDEPEND=">=dev-lang/mono-1.0
		 >=dev-dotnet/gtk-sharp-2.4.0
		 >=dev-dotnet/gnome-sharp-2.4.0
		 =x11-libs/gtksourceview-1*"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.19
		>=dev-util/monodoc-1.1.8"

src_prepare() {
	#A sample fails with mono-2.
	sed -i -e 's:sample::' Makefile*
}

src_install() {
	emake DESTDIR="${D}" install || die

	# newer gtksourceview versions install these
	rm "${D}"/usr/share/gtksourceview-1.0/language-specs/{vbnet,nemerle}.lang
}
