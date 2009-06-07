# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gigolo/gigolo-0.3.2.ebuild,v 1.1 2009/06/07 18:31:05 darkside Exp $

EAPI=1

inherit xfce4

xfce4_goodies

DESCRIPTION="a frontend to easily manage connections to remote filesystems using
GIO/GVfs"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=x11-libs/gtk+-2.12:2
	>=dev-libs/glib-2.16:2"
RDEPEND="${DEPEND}"

DOCS="AUTHORS ChangeLog NEWS README TODO"

src_compile() {
	./waf --prefix="/usr" --libdir="/usr/$(get_libdir)" configure \
			|| die "./waf configure failed"

	# Build takes -jX, but not -lX so cannot use $MAKEOPTS
	./waf build || die "./waf build failed"
}

src_install() {
	./waf --destdir="${D}" install || die "./waf install failed"

	# process docs
	dodoc ${DOCS}
	rm -rf "${D}"/usr/share/doc/${PN}
}
