# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-alarm/xmms-alarm-0.3.3.ebuild,v 1.1 2003/09/15 15:03:43 vapier Exp $

DESCRIPTION="An alarm plugin for XMMS"
HOMEPAGE="http://www.snika.uklinux.net/index.php?show=xmms-alarm"
SRC_URI="http://www.snika.uklinux.net/xmms-alarm/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~mips ~arm"

DEPEND="=x11-libs/gtk+-1.2*
	media-sound/xmms"

src_compile() {
	econf \
		--program-suffix=-dev \
		--program-transform-name=libalarm-dev \
		|| die "conf failed"
	emake || die "build failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	dodoc AUTHORS COPYING ChangeLog INSTALL README NEWS
}
