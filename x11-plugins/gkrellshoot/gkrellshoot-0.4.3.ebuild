# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellshoot/gkrellshoot-0.4.3.ebuild,v 1.4 2006/10/21 23:38:32 kloeri Exp $

inherit multilib

S=${WORKDIR}/${P/s/S}
DESCRIPTION="GKrellm2 plugin to take screen shots and lock screen"
HOMEPAGE="http://gkrellshoot.sourceforge.net/"
SRC_URI="mirror://sourceforge/gkrellshoot/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-2*
	>=app-admin/gkrellm-2"
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
