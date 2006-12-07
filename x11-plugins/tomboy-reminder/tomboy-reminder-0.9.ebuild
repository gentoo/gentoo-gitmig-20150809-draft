# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/tomboy-reminder/tomboy-reminder-0.9.ebuild,v 1.1 2006/12/07 20:43:16 compnerd Exp $

inherit mono eutils

DESCRIPTION="Reminder Plugin for Tomboy"
HOMEPAGE="http://raphael.slinckx.net/blog/projects/tomboy-reminder-plugin/"
SRC_URI="http://raphael.slinckx.net/files/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=dev-lang/mono-1.0
		   app-misc/tomboy"
DEPEND="${RDEPEND}
		>=dev-util/pkgconfig-0.19"

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	dodoc README NEWS ChangeLog AUTHORS
}
