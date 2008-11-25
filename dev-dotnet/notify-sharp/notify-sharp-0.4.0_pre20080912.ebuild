# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/notify-sharp/notify-sharp-0.4.0_pre20080912.ebuild,v 1.1 2008/11/25 14:22:25 loki_val Exp $

EAPI=2

inherit autotools mono

MY_P=${PN}-${PV#*_pre}

DESCRIPTION="notify-sharp is a C# client implementation for Desktop Notifications"
HOMEPAGE="http://www.ndesk.org/NotifySharp"
SRC_URI="http://cvs.fedora.redhat.com/repo/pkgs/${PN}/${MY_P}.tar.bz2/098f3cde158cf26d3efedbfcc19c70dd/${MY_P}.tar.bz2"
LICENSE="as-is"
SLOT="0"

KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=dev-lang/mono-1.1.13
	>=dev-dotnet/gtk-sharp-2.10.1
	>=dev-dotnet/dbus-sharp-0.6
	>=dev-dotnet/dbus-glib-sharp-0.4"
DEPEND="${RDEPEND}
	dev-util/monodoc"

S=${WORKDIR}/${MY_P}

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

