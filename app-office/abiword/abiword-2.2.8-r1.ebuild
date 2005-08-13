# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-2.2.8-r1.ebuild,v 1.7 2005/08/13 09:58:34 gmsoft Exp $

inherit eutils fdo-mime alternatives

IUSE="gnome jpeg spell xml2 debug"

S_P=${S}/${PN}-plugins
S=${WORKDIR}/${P}/abi

DESCRIPTION="Fully featured yet light and fast cross platform word processor"
HOMEPAGE="http://www.abisource.com"

SRC_URI="http://www.abisource.com/downloads/${PN}/${PV}/source/${P}.tar.bz2"

KEYWORDS="alpha ~amd64 hppa ~ia64 ppc ppc64 sparc x86"
LICENSE="GPL-2"
SLOT="2"

RDEPEND="virtual/x11
	virtual/xft
	>=media-libs/fontconfig-2.1
	media-libs/libpng
	>=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2
	>=app-text/wv-1
	>=dev-libs/fribidi-0.10.4
	jpeg?  ( >=media-libs/jpeg-6b-r2 )
	xml2? ( >=dev-libs/libxml2-2.4.10 )
	!xml2? ( dev-libs/expat )
	spell? ( >=app-text/enchant-1.1 )
	gnome? ( >=gnome-base/libgnomeui-2.2
		>=gnome-base/libgnomeprint-2.2.1
		>=gnome-base/libgnomeprintui-2.2.1
		>=gnome-base/libbonobo-2
		>=gnome-extra/gucharmap-1.4 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {

	# this is a hack since I don't want to go hack in the gnome-vfs headerfiles.
	# The issue is about gnome-vfs containing "long long" which makes gcc 3.3.1 balk
	cp configure configure.old
	cat configure.old |sed s:-pedantic::g >configure
	rm -f configure.old

	# Fix compilation on GCC4; upstream patch
	epatch ${FILESDIR}/2.2.8-gcc4.patch

	# fix for security, see #96991
	epatch ${FILESDIR}/${PN}-security-fix.patch

	econf \
		`use_enable gnome` \
		`use_enable gnome gucharmap` \
		`use_with xml2 libxml2` \
		`use_enable spell enchant` \
		`use_enable debug` \
		--enable-bidi \
		--enable-threads \
		--without-ImageMagick \
		--disable-scripting \
		--with-sys-wv || die

	emake all-recursive || die

	# Build plugins

	cd ${S_P}

	econf \
		`use_enable debug` \
		--enable-all \
		--with-abiword=${S} \
		--without-ImageMagick || die

	emake || die

}

src_install() {

	dodir /usr/{bin,lib}

	make DESTDIR=${D} install || die

	dosed "s:Exec=abiword:Exec=abiword-2.2:" /usr/share/applications/abiword.desktop

	rm -f ${D}/usr/bin/abiword-2.2
	rm -f ${D}/usr/bin/abiword
	dosym AbiWord-2.2 /usr/bin/abiword-2.2

	dodoc COPYING *.TXT docs/build/BUILD.TXT user/wp/readme.txt

	# install plugins

	cd ${S_P}

	make DESTDIR=${D} install || die

}

pkg_postinst() {

	fdo-mime_desktop_database_update

	alternatives_auto_makesym "/usr/bin/abiword" "/usr/bin/abiword-[0-9].[0-9]"

}
