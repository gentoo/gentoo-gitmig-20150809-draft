# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/abiword/abiword-2.4.6.ebuild,v 1.19 2011/02/13 14:39:39 pacho Exp $

inherit alternatives eutils fdo-mime

DESCRIPTION="Fully featured yet light and fast cross platform word processor"
HOMEPAGE="http://www.abisource.com/"
SRC_URI="http://www.abisource.com/downloads/${PN}/${PV}/source/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86-fbsd"
IUSE="debug gnome spell xml"

RDEPEND="dev-libs/popt
		 sys-libs/zlib
		 >=dev-libs/glib-2
		 >=x11-libs/gtk+-2.4
		 >=x11-libs/pango-1.2
		 x11-libs/libXft
		 >=gnome-base/libglade-2
		 >=gnome-base/libgnomeprint-2.2
		 >=gnome-base/libgnomeprintui-2.2
		 >=media-libs/libpng-1.2
		 >=media-libs/fontconfig-2.1
		 >=app-text/wv-1
		 >=dev-libs/fribidi-0.10.4
		 xml? ( >=dev-libs/libxml2-2.4.10 )
		 !xml? ( dev-libs/expat )
		 spell? ( >=app-text/enchant-1.1 )
		 gnome?	(
					>=gnome-base/libbonobo-2
					>=gnome-base/libgnomeui-2.2
					>=gnome-extra/gucharmap-1.4
				)"

DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.9"

S="${WORKDIR}/${P}/abi"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/11_history_fullpath.dpatch
	epatch "${FILESDIR}"/freebsd_fix.patch
}

src_compile() {
	econf $(use_enable debug)           \
		  $(use_enable debug symbols)   \
		  $(use_enable gnome)           \
		  $(use_enable gnome gucharmap) \
		  $(use_enable spell enchant)   \
		  $(use_with xml libxml2)       \
		  "--enable-threads"            \
		  "--disable-scripting"         \
		  "--with-sys-wv"               \
	|| die "configure failed"

	emake all-recursive || die "build failed"
}

src_install() {
	dodir /usr/{bin,lib}
	emake DESTDIR="${D}" icondir="/usr/share/pixmaps" install || die "install failed"

	dosed "s:Exec=abiword:Exec=abiword-2.4:" /usr/share/applications/abiword.desktop

	rm -f "${D}"/usr/bin/abiword
	rm -f "${D}"/usr/bin/abiword-2.4
	dosym AbiWord-2.4 /usr/bin/abiword-2.4

	dodoc *.TXT user/wp/readme.txt
}

pkg_postinst() {
	fdo-mime_desktop_database_update

	alternatives_auto_makesym "/usr/bin/abiword" "/usr/bin/abiword-[0-9].[0-9]"

	elog "As of version 2.4, all abiword plugins have been moved"
	elog "into a seperate abiword-plugins package"
	elog "You can install them by running emerge abiword-plugins"
}
