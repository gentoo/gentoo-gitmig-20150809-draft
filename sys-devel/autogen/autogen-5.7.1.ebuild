# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autogen/autogen-5.7.1.ebuild,v 1.9 2006/08/25 07:42:35 corsair Exp $

DESCRIPTION="Program and text file generation"
HOMEPAGE="http://www.gnu.org/software/autogen/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~s390 ~sparc x86"
IUSE=""

# autogen doesn't build with lower versions of guile on ia64
DEPEND=">=dev-util/guile-1.6.6
	dev-libs/libxml2"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# autogen-5.7.1 doesn't build the docs ...
	# http://sourceforge.net/mailarchive/forum.php?thread_id=7629430&forum_id=7034
	sed -i -e '/SUBDIRS = /s/ doc\>//' Makefile.in
}

src_compile() {
	econf || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"
	rm -f ${D}/usr/share/autogen/libopts-*.tar.gz
}
