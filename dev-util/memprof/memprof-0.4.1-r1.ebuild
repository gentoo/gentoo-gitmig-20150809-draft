# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/memprof/memprof-0.4.1-r1.ebuild,v 1.3 2002/07/23 13:28:37 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="MemProf - Profiling and leak detection"
SRC_URI="http://people.redhat.com/otaylor/memprof/${P}.tar.gz"
HOMEPAGE="http://people.redhat.com/otaylor/memprof/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=gnome-base/gnome-libs-1.4.1.2-r1
	 sys-devel/binutils
	 >=gnome-base/libglade-0.17-r1"

RDEPEND="${DEPEND}
	nls? ( sys-devel/gettext )"
	
src_compile() {
	local myconf

	use nls || myconf="--disable-nls"
	
	econf \
		--disable-more-warnings \
		${myconf} || die

	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog README NEWS TODO
}
