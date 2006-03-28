# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/lahelper/lahelper-0.6.3.ebuild,v 1.4 2006/03/28 22:58:30 ehmsen Exp $

inherit eutils

DESCRIPTION="LaHelper (LaTeX Helper) is a GNOME document preparation GUI for LaTeX"
HOMEPAGE="http://lahelper.sourceforge.net/"
SRC_URI="mirror://sourceforge/lahelper/${P}-1.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	=gnome-base/gnome-libs-1.4*
	gnome-base/bonobo
	virtual/tetex"
RDEPEND="${DEPEND}
	~media-gfx/eog-0.6
	media-gfx/imagemagick"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
	sed -i -e "s:/usr/include/zvt:/usr/include/gnome-1.0/zvt:g" configure*
	find . -type f | xargs sed -i -e "s%/usr/local/share%/usr/share%g"
}

src_compile() {
	econf || die "could not configure"
	emake || die "emake failed"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog NEWS README*
}
