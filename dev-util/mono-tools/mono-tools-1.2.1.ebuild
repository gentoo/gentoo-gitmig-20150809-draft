# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mono-tools/mono-tools-1.2.1.ebuild,v 1.8 2010/03/27 08:54:48 ssuominen Exp $

inherit eutils mono multilib autotools

DESCRIPTION="Set of useful Mono related utilities"
HOMEPAGE="http://www.mono-project.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="dev-lang/mono
	>=virtual/monodoc-${PV}
	=dev-dotnet/gtk-sharp-2*
	=dev-dotnet/glade-sharp-2*
	=dev-dotnet/gconf-sharp-2*
	=dev-dotnet/gtkhtml-sharp-2*"
DEPEND="${RDEPEND}
	sys-devel/gettext"

# Parallel build unfriendly
MAKEOPTS="${MAKEOPTS} -j1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Make the browser optional
	epatch "${FILESDIR}/${PN}-1.1.17-html-renderer-fixes.diff"

	# Install all our .dlls under $(libdir), not $(prefix)/lib
	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e 's:$(prefix)/lib:$(libdir):'                    \
			"${S}"/{asn1view/gtk,docbrowser,gnunit/src}/Makefile.am \
		|| die "sed failed"

		sed -i -e 's:$prefix/lib:@libdir@:' \
			"${S}"/docbrowser/monodoc.in      \
		|| die "sed failed"
	fi

	eautoreconf
}

src_compile() {
	local myconf="--enable-gtkhtml --disable-mozilla"

	econf ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc ChangeLog README
}
