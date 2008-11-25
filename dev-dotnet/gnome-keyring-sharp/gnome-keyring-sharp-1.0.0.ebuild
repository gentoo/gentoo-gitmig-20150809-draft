# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/gnome-keyring-sharp/gnome-keyring-sharp-1.0.0.ebuild,v 1.2 2008/11/25 13:53:54 loki_val Exp $

EAPI=2

inherit mono

DESCRIPTION="C# implementation of gnome-keyring"
HOMEPAGE="http://www.mono-project.com/"
SRC_URI="http://ftp.novell.com/pub/mono/sources/${PN}/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="dbus"

RDEPEND="dev-lang/mono
	dbus? ( dev-dotnet/dbus-sharp )"
DEPEND="${RDEPEND}
	dev-util/monodoc
	dev-util/pkgconfig"

src_prepare() {
	# Disable building samples.
	sed -i -e 's:sample::' "${S}"/Makefile.in || die "sed failed"
}

src_configure() {
	econf $(use_enable dbus) || die "econf failed"
}

src_compile() {
	# This dies a horrible death with anything other than "-j1".
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog README
}
