# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ksplash/ksplash-4.8.5-r1.ebuild,v 1.1 2012/08/18 00:46:10 johu Exp $

EAPI=4

KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="KDE splashscreen framework (the splashscreen of KDE itself, not of individual apps)"
SRC_URI+=" http://dev.gentoo.org/~johu/distfiles/${P}-default-theme.patch.xz"

KEYWORDS="~amd64 ~arm ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux"
IUSE="3dnow altivec debug mmx sse sse2 xinerama"

COMMONDEPEND="
	media-libs/libpng
	xinerama? ( x11-libs/libXinerama )
"
DEPEND="${COMMONDEPEND}
	xinerama? ( x11-proto/xineramaproto )
"
RDEPEND="${COMMONDEPEND}"

src_prepare() {
	kde4-meta_src_prepare

	epatch "${DISTDIR}/${P}-default-theme.patch.xz"
}

src_configure() {
	mycmakeargs=(
		$(cmake-utils_use_has 3dnow X86_3DNOW)
		$(cmake-utils_use_has altivec PPC_ALTIVEC)
		$(cmake-utils_use_has mmx X86_MMX)
		$(cmake-utils_use_has sse X86_SSE)
		$(cmake-utils_use_has sse2 X86_SSE2)
		$(cmake-utils_use_with xinerama)
	)

	kde4-meta_src_configure
}
