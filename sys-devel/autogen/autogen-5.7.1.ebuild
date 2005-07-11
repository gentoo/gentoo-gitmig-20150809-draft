# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autogen/autogen-5.7.1.ebuild,v 1.1 2005/07/11 03:49:21 agriffis Exp $

DESCRIPTION="Program and text file generation"
HOMEPAGE="http://www.gnu.org/software/autogen/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~x86 ~ia64 ~ppc"
IUSE=""

# autogen doesn't build with lower versions of guile on ia64
DEPEND=">=dev-util/guile-1.6.6
	dev-libs/libxml2"

src_unpack() {
	unpack ${A}
	cd ${S}
	# autogen-5.7.1 doesn't build the docs ...
	# http://sourceforge.net/mailarchive/forum.php?thread_id=7629430&forum_id=7034
	sed -i -e '/SUBDIRS = /s/ doc\>//' Makefile.in
}

src_compile() {
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"
	rm -f ${D}/usr/share/autogen/libopts-*.tar.gz
}
