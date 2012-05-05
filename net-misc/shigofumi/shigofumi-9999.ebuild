# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/shigofumi/shigofumi-9999.ebuild,v 1.5 2012/05/05 03:20:42 jdhore Exp $

EAPI=4

[[ ${PV} = 9999* ]] && GIT="git-2 autotools"
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
	virtual/pkgconfig
	app-text/docbook-xsl-stylesheets"

DOCS=( NEWS README AUTHORS ChangeLog )

src_prepare() {
	[[ ${PV} = 9999* ]] && eautoreconf
}

src_configure() {
	econf \
		--disable-fatalwarnings \
		$(use_enable debug) \
		$(use_enable nls) \
		$(use_enable xattr)
}
