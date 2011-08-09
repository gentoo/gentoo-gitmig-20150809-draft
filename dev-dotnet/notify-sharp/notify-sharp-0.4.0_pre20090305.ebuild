# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/notify-sharp/notify-sharp-0.4.0_pre20090305.ebuild,v 1.4 2011/08/09 17:44:49 xarthisius Exp $

EAPI=4
inherit autotools mono

MY_P=${PN}-${PV#*_pre}

DESCRIPTION="a C# client implementation for Desktop Notifications"
HOMEPAGE="http://www.ndesk.org/NotifySharp"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
LICENSE="as-is"
SLOT="0"

KEYWORDS="amd64 ~ppc x86"
IUSE="doc"

RDEPEND=">=dev-lang/mono-1.1.13
	>=dev-dotnet/gtk-sharp-2.10.1
	>=dev-dotnet/dbus-sharp-0.6
	>=dev-dotnet/dbus-sharp-glib-0.4
	>=x11-libs/libnotify-0.4.5"
DEPEND="${RDEPEND}
	doc? ( virtual/monodoc )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.4.0_pre20080912-control-docs.patch" \
		"${FILESDIR}/${P}-dbus-sharp.patch"
	eautoreconf
}

src_configure() {
	econf $(use_enable doc docs)
}
