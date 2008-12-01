# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop-boo/monodevelop-boo-1.0.ebuild,v 1.2 2008/12/01 09:08:55 flameeyes Exp $

inherit autotools eutils mono multilib

DESCRIPTION="Boo Extension for MonoDevelop"
HOMEPAGE="http://www.monodevelop.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-util/monodevelop-${PV}
		>=dev-lang/boo-0.7.9.2659
		>=dev-dotnet/gtksourceview-sharp-0.11"

DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.19"

MAKEOPTS="-j1 ${MAKEOPTS}"

pkg_setup() {
	if ! built_with_use dev-util/monodevelop cxx; then
		eerror "Please re-emerge dev-util/monodevelop with the cxx USE flag set"
		die "monodevelop-boo needs the cxx flag set"
	fi
}

src_compile() {
	MD_BOO_CONFIG=""
	if use debug; then
		MD_BOO_CONFIG="--config=DEBUG"
	else
		MD_BOO_CONFIG="--config=RELEASE"
	fi

	./configure \
		--prefix=/usr		\
		${MD_BOO_CONFIG}	\
	|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
