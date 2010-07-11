# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mono-tools/mono-tools-1.2.4.ebuild,v 1.11 2010/07/11 17:54:29 armin76 Exp $

inherit eutils mono multilib autotools

DESCRIPTION="Set of useful Mono related utilities"
HOMEPAGE="http://www.mono-project.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86 ~x86-fbsd"
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

	# Fix installing on FreeBSD
	epatch "${FILESDIR}/${P}-install.patch"

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
