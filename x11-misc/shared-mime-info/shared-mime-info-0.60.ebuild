# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/shared-mime-info/shared-mime-info-0.60.ebuild,v 1.3 2009/04/19 02:23:40 leio Exp $

EAPI="2"

inherit autotools eutils fdo-mime

DESCRIPTION="The Shared MIME-info Database specification"
HOMEPAGE="http://freedesktop.org/wiki/Software/shared-mime-info"
SRC_URI="http://people.freedesktop.org/~hadess/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2.6
	>=dev-libs/libxml2-2.4"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.40
	sys-devel/gettext"

src_prepare() {
	# Fix broken make call, upstream bug #20522.
	epatch "${FILESDIR}/${P}-parallel-make.patch"

	eautomake
}

src_configure() {
	econf \
		--disable-dependency-tracking \
		--disable-update-mimedb
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc ChangeLog HACKING NEWS README || die "dodoc failed."
}

pkg_postinst() {
	fdo-mime_mime_database_update

	# see bug #228885
	elog
	elog "The database format has changed between 0.30 and 0.40."
	elog "You may need to update all your local databases and caches."
	elog "To do so, please run the following commands:"
	elog "(for each user) $ update-mime-database ~/.local/share/mime/"
	elog "(as root)       # update-mime-database /usr/local/share/mime/"
	elog
}
