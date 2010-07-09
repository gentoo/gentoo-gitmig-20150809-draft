# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/shigofumi/shigofumi-9999.ebuild,v 1.2 2010/07/09 10:51:23 scarabeus Exp $

EAPI=3

[[ ${PV} = 9999* ]] && GIT="git autotools"
EGIT_REPO_URI='git://repo.or.cz/shigofumi.git'
WANT_AUTOMAKE="1.11"
inherit base ${GIT}

DESCRIPTION="Command line client for ISDS"
HOMEPAGE="http://xpisar.wz.cz/shigofumi/"
if [[ ${PV} = 9999* ]]; then
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://xpisar.wz.cz/${PN}/dist/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE="debug nls xattr"

RDEPEND=">=net-libs/libisds-0.3
	sys-libs/readline
	dev-libs/confuse
	dev-libs/libxml2"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	dev-libs/libxslt
	dev-util/pkgconfig
	app-text/docbook-xsl-stylesheets"

DOCS=( "NEWS" "README" "AUTHORS" "ChangeLog" )

src_prepare() {
	base_src_prepare
	[[ ${PV} = 9999* ]] && eautoreconf
}

src_configure() {
	econf \
		--disable-fatalwarnings \
		$(use_enable debug) \
		$(use_enable nls) \
		$(use_enable xattr)
}
