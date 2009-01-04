# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/pnetlib/pnetlib-0.6.12.ebuild,v 1.13 2009/01/04 23:00:13 ulm Exp $

inherit eutils autotools

DESCRIPTION="Portable.NET C# library"
HOMEPAGE="http://www.dotgnu.org/"
SRC_URI="mirror://gnu/dotgnu/pnet/${P}.tar.gz"

LICENSE="GPL-2-with-linking-exception"
SLOT="0"
KEYWORDS="amd64 arm ~hppa ia64 ppc x86"
IUSE="truetype X"

DEPEND="=dev-dotnet/pnet-${PV}*
	X? ( x11-libs/libSM
		x11-libs/libXft )
	truetype? ( x11-libs/libXft )
	=sys-devel/automake-1.4_p6"

RDEPEND="=dev-dotnet/pnet-${PV}*
	X? ( x11-libs/libSM
		x11-libs/libXft )
	truetype? ( x11-libs/libXft )"

src_unpack() {
	unpack ${A}
	cd ${S}
	# patch configure.in to detect renamed resgen.pnet
	# bug 39369
	epatch ${FILESDIR}/${PV}-resgen.patch

	# syntax error; already fixed upstream
	epatch ${FILESDIR}/configure-freetype.patch

	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	local lib_profile="default1.1"
	einfo "Using profile: ${lib_profile}"

	econf --with-profile=${lib_profile} \
		`use_enable truetype xft` || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog HACKING INSTALL NEWS README
	dodoc doc/*.txt
	dohtml doc/*.html
}
