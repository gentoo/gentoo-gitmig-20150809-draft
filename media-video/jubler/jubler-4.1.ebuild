# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/jubler/jubler-4.1.ebuild,v 1.1 2009/05/06 18:06:21 serkan Exp $

EAPI="2"
inherit gnome2-utils eutils java-pkg-2 java-ant-2 toolchain-funcs

MY_PN=${PN/#j/J}
DESCRIPTION="Java subtitle editor"
HOMEPAGE="http://www.jubler.org/"
SRC_URI="mirror://gentoo/${MY_PN}-src-${PV}.tar.bz2"
# This is a patched tarball generated from Mercurial.

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mplayer nls spell"

RDEPEND=">=virtual/jre-1.5
	>=media-video/ffmpeg-0.4.9_p20080326
	mplayer? ( media-video/mplayer[ass] )
	spell?
	(
		app-text/aspell
		>=dev-java/zemberek-2.0[linguas_tr]
	)
	dev-java/jupidator"

DEPEND=">=virtual/jdk-1.5
	>=media-video/ffmpeg-0.4.9_p20080326
	app-text/docbook-sgml-utils
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	dev-java/jupidator"

S=${WORKDIR}/${MY_PN}-${PV}

java_prepare() {
	chmod +x resources/installers/linux/iconinstall
	JAVA_ANT_CLASSPATH_TAGS="java javac" java-ant_rewrite-classpath
	java-ant_rewrite-classpath nbproject/build-impl.xml
}

src_compile() {
	java-pkg_filter-compiler ecj-3.2
	eant -Dgentoo.classpath="$(java-pkg_getjars jupidator)" distbased $(use nls && echo i18n) jar faq changelog || die "eant failed"
	cp -v dist/help/jubler-faq.html build/classes/help || die "cp failed"
	cd resources/ffdecode || die
	CC=$(tc-getCC) NOSTRIP=true emake linuxdyn || die "make failed"
}

src_install() {
	java-pkg_dojar dist/Jubler.jar
	use spell && java-pkg_register-dependency zemberek zemberek2-cekirdek.jar
	use spell && java-pkg_register-dependency zemberek zemberek2-tr.jar
	java-pkg_doso resources/ffdecode/libffdecode.so
	doicon resources/installers/linux/jubler.png
	domenu resources/installers/linux/jubler.desktop

	DESTDIR="${D}" eant linuxdesktopintegration
	rm -vr "${D}/usr/share/menu" || die

	java-pkg_dolauncher jubler --main com.panayotis.jubler.Main
	dohtml ChangeLog.html || die "dohtml failed"
	dodoc README || die "dodoc failed"
	doman resources/installers/linux/jubler.1 || die "doman fialed"
	insinto /usr/share/jubler/help
	doins dist/help/* || die "doins failed"
}

pkg_preinst() {
	gnome2_pkg_preinst
	java-pkg-2_pkg_preinst
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
