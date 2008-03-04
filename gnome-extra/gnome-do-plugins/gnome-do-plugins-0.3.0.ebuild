# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gnome-do-plugins/gnome-do-plugins-0.3.0.ebuild,v 1.2 2008/03/04 19:19:23 graaff Exp $

inherit eutils autotools gnome2 mono

MY_PN="do-plugins"

DESCRIPTION="Plugins to put the Do in Gnome Do"
HOMEPAGE="http://do.davebsd.com/"
SRC_URI="https://launchpad.net/do/trunk/0.3.2.1/+download/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="amarok evo"

DEPEND=">=gnome-extra/gnome-do-${PV}
		evo? ( dev-dotnet/evolution-sharp )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}-${PV}"

src_unpack()
{
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/do-plugins-optional-ext-dep.patch"
	eautoreconf || die "reconfigure failed"
}

src_compile()
{
	econf \
		$(use_enable amarok amarok-plugin) \
		$(use_enable evo evolution-plugin) \
		|| die "configure failed"
	emake || die "make failed"
}
