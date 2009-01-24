# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gnome-keyring-sharp/gnome-keyring-sharp-1.0.0-r1.ebuild,v 1.1 2009/01/24 01:20:16 loki_val Exp $

EAPI=2

inherit mono eutils autotools

DESCRIPTION="C# implementation of gnome-keyring"
HOMEPAGE="http://www.mono-project.com/"
SRC_URI="http://ftp.novell.com/pub/mono/sources/${PN}/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="dbus doc"

RDEPEND=">=dev-lang/mono-2.0
	>=gnome-base/gnome-keyring-2.22
	dbus? ( dev-dotnet/dbus-sharp )
	doc? ( virtual/monodoc )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	# https://bugzilla.novell.com/show_bug.cgi?id=469141
	epatch "${FILESDIR}/${P}-monodoc.patch"
	eautoreconf
	# Disable building samples.
	sed -i -e 's:sample::' "${S}"/Makefile.in || die "sed failed"
}

src_configure() {
	econf	$(use_enable dbus) \
		$(use_enable doc monodoc) || die "econf failed"
}

src_compile() {
	# This dies without telling in docs with anything not -j1
	# CSC=gmcs needed for http://bugs.gentoo.org/show_bug.cgi?id=250069
	emake -j1 CSC=gmcs || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
	mono_multilib_comply
	find "${D}" -name '*.la' -exec rm -rf '{}' '+' || die "la removal failed"
}
