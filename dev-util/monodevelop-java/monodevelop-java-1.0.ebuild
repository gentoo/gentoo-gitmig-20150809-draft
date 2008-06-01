# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodevelop-java/monodevelop-java-1.0.ebuild,v 1.1 2008/06/01 14:57:53 jurek Exp $

inherit autotools eutils mono multilib

DESCRIPTION="Java Extension for MonoDevelop"
HOMEPAGE="http://www.monodevelop.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND=">=dev-util/monodevelop-${PV}
		|| ( >=dev-dotnet/ikvm-0.14.0.1-r1 >=dev-dotnet/ikvm-bin-0.14.0.1 )"

DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.19"

MAKEOPTS="-j1 ${MAKEOPTS}"

src_compile() {
	MD_JAVA_CONFIG=""
	if use debug; then
		MD_JAVA_CONFIG="--config=DEBUG"
	else
		MD_JAVA_CONFIG="--config=RELEASE"
	fi

	./configure \
		--prefix=/usr		\
		${MD_JAVA_CONFIG}	\
	|| die "configure failed"

	emake || die "make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}
