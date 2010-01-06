# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/uget/uget-9999.ebuild,v 1.1 2010/01/06 12:53:09 wired Exp $

EAPI="2"

inherit autotools subversion

DESCRIPTION="Download manager using gtk+ and libcurl"
HOMEPAGE="http://urlget.sourceforge.net/"
SRC_URI=""

ESVN_REPO_URI="https://urlget.svn.sourceforge.net/svnroot/urlget/trunk"
ESVN_PROJECT="uget"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE="nls"

RDEPEND=">=net-misc/curl-7.10
	>=x11-libs/gtk+-2.4
	>=dev-libs/glib-2
	dev-libs/libpcre"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext"

src_prepare() {
	for i in AUTHORS NEWS README ChangeLog;	do
		[[ ! -f ${i} ]] && touch ${i}
	done

	eautoreconf
	intltoolize || die "intltoolize failed"
	eautoreconf
}

src_configure() {
	econf $(use_enable nls) || die "econf failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
}
