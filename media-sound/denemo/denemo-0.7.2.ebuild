# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/denemo/denemo-0.7.2.ebuild,v 1.1 2004/02/18 10:27:33 torbenh Exp $

DESCRIPTION="GTK+ graphical music notation editor"
HOMEPAGE="http://denemo.sourceforge.net/"
SRC_URI="http://dl.sourceforge.net/sourceforge/denemo/denemo-${PV}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*
	dev-libs/libxml
	dev-util/yacc
	sys-devel/flex
	sys-devel/gettext"
RDEPEND="virtual/glibc
	=x11-libs/gtk+-1.2*
	dev-libs/libxml"

S=${WORKDIR}/${P}

src_compile() {
	econf
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
}
