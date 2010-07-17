# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libbluray/libbluray-9999.ebuild,v 1.1 2010/07/17 02:55:14 beandog Exp $

EAPI=2

inherit autotools git

EGIT_REPO_URI="git://git.videolan.org/libbluray.git"

DESCRIPTION="Blu-ray playback libraries"
HOMEPAGE="http://www.videolan.org/ http://git.videolan.org/?p=libbluray.git;a=summary"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="aacs java"

RDEPEND="aacs? ( media-video/aacskeys )"
DEPEND="java? ( virtual/jdk )"

src_prepare() {
	use java && export JDK_HOME="$(java-config -g JAVA_HOME)"
	eautoreconf
}

src_configure() {
	local myconf=""
	use java && myconf="--with-jdk=${JDK_HOME}"
	econf $myconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc doc/README README.txt TODO.txt
	cd "${S}"/src/examples/
	dobin clpi_dump index_dump mobj_dump mpls_dump sound_dump
	cd "${S}"/src/examples/.libs/
	dobin bdsplice libbluray_test list_titles
}
