# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-dotnet/notify-sharp/notify-sharp-0.4.0_pre20080912-r1.ebuild,v 1.8 2011/03/12 11:56:18 angelos Exp $

EAPI=2

inherit autotools mono

MY_P=${PN}-${PV#*_pre}

DESCRIPTION="notify-sharp is a C# client implementation for Desktop Notifications"
HOMEPAGE="http://www.ndesk.org/NotifySharp"
SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
#http://cvs.fedora.redhat.com/repo/pkgs/${PN}/${MY_P}.tar.bz2/098f3cde158cf26d3efedbfcc19c70dd/${MY_P}.tar.bz2
LICENSE="as-is"
SLOT="0"

KEYWORDS="amd64 ppc x86"
IUSE="doc"

RDEPEND=">=dev-lang/mono-1.1.13
	>=dev-dotnet/gtk-sharp-2.10.1
	>=dev-dotnet/ndesk-dbus-0.6
	>=dev-dotnet/ndesk-dbus-glib-0.4
	>=x11-libs/libnotify-0.4.5"
DEPEND="${RDEPEND}
	doc? ( virtual/monodoc )"

S=${WORKDIR}/${MY_P}

MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	epatch "${FILESDIR}/${P}-control-docs.patch"
	eautoreconf
}

src_configure() {
	econf $(use_enable doc docs)
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
