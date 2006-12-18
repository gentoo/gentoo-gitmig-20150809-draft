# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/shared-mime-info/shared-mime-info-0.18-r1.ebuild,v 1.4 2006/12/18 14:33:56 gustavoz Exp $

inherit eutils fdo-mime

DESCRIPTION="The Shared MIME-info Database specification"
HOMEPAGE="http://www.freedesktop.org/software/shared-mime-info"
SRC_URI="http://www.freedesktop.org/~hadess/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ppc ~ppc64 ~s390 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/libxml2-2.4"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"

src_unpack() {

	unpack ${A}

	cd ${S}
	# make pkgconfig .pc libdir safe
	epatch ${FILESDIR}/${PN}-0.17-fix_pc.patch
	# fix m4a match pattern offset (#142342)
	epatch ${FILESDIR}/${P}-m4a_offset.patch

}

src_compile() {

	econf --disable-update-mimedb || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	dodoc ChangeLog NEWS README

}

pkg_postinst() {

	fdo-mime_mime_database_update

}

# FIXME :
# This ebuild should probably also remove the stuff it now leaves behind
# in /usr/share/mime
