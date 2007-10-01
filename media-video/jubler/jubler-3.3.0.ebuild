# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/jubler/jubler-3.3.0.ebuild,v 1.3 2007/10/01 20:17:22 swegener Exp $

inherit eutils java-pkg-2 java-utils-2 java-ant-2 toolchain-funcs flag-o-matic

MY_PN=${PN/#j/J}
DESCRIPTION="Java subtitle editor"
HOMEPAGE="http://www.panayotis.com/jubler/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-src-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="nls spell kde"

RDEPEND=">=virtual/jre-1.5
	media-video/ffmpeg
	spell?
	(
		app-text/aspell
		>=dev-java/zemberek-2.0
	)"

DEPEND=">=virtual/jdk-1.5
	media-video/ffmpeg
	app-text/docbook-sgml-utils
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_PN}-${PV}

pkg_setup() {
	if use spell && ! built_with_use dev-java/zemberek linguas_tr; then
		die "Zemberek should be built with Turkish language support"
	fi
	java-pkg-2_pkg_setup
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	local anttasks_opt
	use nls && anttasks_opt="i18n"
	eant ${anttasks_opt} jar faq || die "eant failed"
	cp -v dist/help/jubler-faq.html build/classes/help || die "cp failed"
	cd resources/ffdecode || die
	CC=$(tc-getCC) emake linuxdyn || "make failed"
}

src_install() {
	java-pkg_dojar dist/Jubler.jar
	use spell && java-pkg_register-dependency zemberek zemberek2-cekirdek.jar
	use spell && java-pkg_register-dependency zemberek zemberek2-tr.jar
	java-pkg_doso resources/ffdecode/libffdecode.so
	doicon resources/installers/linux/jubler.png
	newicon resources/installers/linux/subtitle-32.png subtitle.png
	java-pkg_dolauncher jubler --main com.panayotis.jubler.Main
	make_desktop_entry ${PN} "Jubler" ${PN}.png
	doman resources/installers/linux/jubler.1
	insinto /usr/share/jubler/help
	doins dist/help/*
	insinto /usr/share/mimelnk/application
	use kde && doins resources/installers/linux/sub-*.desktop
}
