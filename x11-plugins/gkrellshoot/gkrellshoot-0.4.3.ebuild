# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellshoot/gkrellshoot-0.4.3.ebuild,v 1.2 2005/04/27 17:55:48 herbs Exp $

inherit multilib

S=${WORKDIR}/${P/s/S}
DESCRIPTION="GKrellm2 plugin to take screen shots and lock screen"
HOMEPAGE="http://gkrellshoot.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkrellshoot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~x86 ~sparc ~alpha ~amd64 ~ppc"
IUSE=""

DEPEND="=x11-libs/gtk+-2*
	>=app-admin/gkrellm-2*"
RDEPEND="${DEPEND}
	media-gfx/imagemagick"

src_compile() {
	export CFLAGS="${CFLAGS/-O?/}"
	emake || die "emake failed"
}

src_install () {
	insinto /usr/$(get_libdir)/gkrellm2/plugins
	doins gkrellshoot.so
	dodoc README ChangeLog
}
