# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mono-tools/mono-tools-1.2.6.ebuild,v 1.4 2010/07/11 17:54:29 armin76 Exp $

inherit mono multilib eutils

DESCRIPTION="Set of useful Mono related utilities"
HOMEPAGE="http://www.mono-project.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-lang/mono-1.0
	>=virtual/monodoc-${PV}
	=dev-dotnet/gtk-sharp-2*
	=dev-dotnet/glade-sharp-2*
	=dev-dotnet/gconf-sharp-2*
	=dev-dotnet/gtkhtml-sharp-2*"
DEPEND="${RDEPEND}
	sys-devel/gettext
	>=dev-util/pkgconfig-0.19"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Make the browser optional
	epatch "${FILESDIR}/${PN}-1.2.6-html-renderer-fixes.patch"

	# Install all our .dlls under $(libdir), not $(prefix)/lib
	find "${S}" -name 'Makefile*' -exec \
		sed -i -e "s:\$(prefix)/lib:\$(prefix)/$(get_libdir):g" \
			   -e "s:\${prefix}/lib:\${prefix}/$(get_libdir):g" \
		{} \; \
	|| die "libdir fixup failed"

	sed -i -e 's:$prefix/lib:@libdir@:' \
		"${S}"/docbrowser/monodoc.in    \
	|| die "sed failed"
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
