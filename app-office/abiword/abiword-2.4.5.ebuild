# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-2.4.5.ebuild,v 1.4 2006/08/17 13:39:46 jer Exp $

inherit eutils fdo-mime alternatives

S=${WORKDIR}/${P}/abi

DESCRIPTION="Fully featured yet light and fast cross platform word processor"
HOMEPAGE="http://www.abisource.com/"

SRC_URI="http://www.abisource.com/downloads/${PN}/${PV}/source/${P}.tar.bz2"

KEYWORDS="~alpha ~amd64 hppa ~ia64 ~ppc ppc64 sparc ~x86"
IUSE="debug gnome spell xml"

LICENSE="GPL-2"
SLOT="2"

RDEPEND="virtual/xft
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2.4
	>=x11-libs/pango-1.2
	>=gnome-base/libglade-2
	>=gnome-base/libgnomeprint-2.2
	>=gnome-base/libgnomeprintui-2.2
	sys-libs/zlib
	>=media-libs/libpng-1.2
	dev-libs/popt
	>=media-libs/fontconfig-2.1
	>=app-text/wv-1
	>=dev-libs/fribidi-0.10.4
	xml? ( >=dev-libs/libxml2-2.4.10 )
	!xml? ( dev-libs/expat )
	spell? ( >=app-text/enchant-1.1 )
	gnome? (
		>=gnome-base/libbonobo-2
		>=gnome-base/libgnomeui-2.2
		>=gnome-extra/gucharmap-1.4 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9"

src_compile() {
	# this is a hack since I don't want to go hack in the gnome-vfs
	# headerfiles. The issue is about gnome-vfs containing "long long"
	# which makes gcc 3.3.1 balk
	sed -i -e 's:-pedantic::g' configure

	local myconf="$(use_enable gnome) \
		$(use_enable gnome gucharmap) \
		$(use_enable spell enchant)   \
		$(use_enable debug)           \
		$(use_with xml libxml2)      \
		--enable-threads    \
		--disable-scripting \
		--with-sys-wv"

	econf $myconf || die "./configure failed"

	emake all-recursive || die "Compilation failed"
}

src_install() {
	dodir /usr/{bin,lib}

	make DESTDIR="${D}" install || die "Installation failed"

	dosed "s:Exec=abiword:Exec=abiword-2.4:" /usr/share/applications/abiword.desktop

	rm -f ${D}/usr/bin/abiword-2.4
	rm -f ${D}/usr/bin/abiword
	dosym AbiWord-2.4 /usr/bin/abiword-2.4

	dodoc *.TXT docs/build/BUILD.TXT user/wp/readme.txt
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	alternatives_auto_makesym "/usr/bin/abiword" "/usr/bin/abiword-[0-9].[0-9]"

	einfo "As of version 2.4, all abiword plugins have been moved"
	einfo "into a seperate abiword-plugins package"
	einfo "You can install them by running emerge abiword-plugins"
}
